import 'package:core/core.dart';
import 'package:core/src/network/src/data/interceptor_handler.dart';
import 'package:core/src/network/src/data/interfaces/network_http_client.dart';
import 'package:core/src/network/src/data/request_handler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockNetworkHttpClient extends Mock implements NetworkHttpClient {}

class _MockNetworkInterceptorHandler extends Mock
    implements NetworkInterceptorHandler {}

class _FakeNetworkRequest extends Fake implements NetworkRequest {}

class _FakeNetworkResponse extends Fake implements NetworkResponse {}

class _FakeInterceptorFailure extends Fake implements InterceptorFailure {
  @override
  HttpFailureType? get type => HttpFailureType.unknown;

  @override
  int? get statusCode => -1;

  @override
  String get message => '';
}

class _FakeNetworkFailure extends Fake implements NetworkFailure {}

void main() {
  late NetworkRequestHandler _requestHandler;
  late NetworkHttpClient _httpClient;
  late NetworkInterceptorHandler _interceptorHandler;

  setUp(() {
    _httpClient = _MockNetworkHttpClient();
    _interceptorHandler = _MockNetworkInterceptorHandler();
    _requestHandler = NetworkRequestHandler(
      httpClient: _httpClient,
      interceptorHandler: _interceptorHandler,
    );
  });

  setUpAll(() {
    registerFallbackValue(_FakeNetworkRequest());
    registerFallbackValue(_FakeNetworkResponse());
    registerFallbackValue(_FakeNetworkFailure());
  });

  group('Method prepareRequest -', () {
    test('Should return $Left when $NetworkInterceptorHandler fails', () async {
      // Arrange
      when(() => _interceptorHandler.onRequest(any())).thenAnswer(
        (_) async => Left(
          _FakeInterceptorFailure(),
        ),
      );
      // Act
      final result = await _requestHandler.prepareRequest(
        NetworkRequestMethod.get,
        'baseUrl',
        'endpoint',
      );
      // Assert
      expect(result, isA<Left>());
      expect(result.left, isA<InterceptorFailure>());
      verify(() => _interceptorHandler.onRequest(any())).called(1);
    });

    test('Should return $Right when $NetworkInterceptorHandler succeeds',
        () async {
      // Arrange
      when(() => _interceptorHandler.onRequest(any())).thenAnswer(
        (_) async => Right(
          _FakeNetworkRequest(),
        ),
      );
      // Act
      final result = await _requestHandler.prepareRequest(
        NetworkRequestMethod.get,
        'baseUrl',
        'endpoint',
      );
      // Assert
      expect(result, isA<Right>());
      expect(result.right, isA<NetworkRequest>());
      verify(() => _interceptorHandler.onRequest(any())).called(1);
    });
  });

  group('Method executeRequest -', () {
    test('Should return $Left when input request is $Left', () async {
      // Arrange
      final request =
          Left<InterceptorFailure, NetworkRequest>(_FakeInterceptorFailure());
      when(() => _interceptorHandler.onError(any())).thenAnswer(
        (_) async => _FakeNetworkFailure(),
      );
      // Act
      final result = await _requestHandler.executeRequest(request);
      // Assert
      expect(result, isA<Left>());
      expect(result.left, isA<NetworkFailure>());
    });

    test('Should return $Left when $NetworkHttpClient throws error', () async {
      // Arrange
      final request =
          Right<InterceptorFailure, NetworkRequest>(_FakeNetworkRequest());
      when(() => _httpClient.request(request.right))
          .thenThrow(GenericFailure());
      when(() => _interceptorHandler.onError(any())).thenAnswer(
        (_) async => _FakeNetworkFailure(),
      );
      // Act
      final result = await _requestHandler.executeRequest(request);
      // Assert
      expect(result, isA<Left>());
      expect(result.left, isA<NetworkFailure>());
      verify(() => _httpClient.request(request.right)).called(1);
    });

    test('Should return $Left when $NetworkHttpClient returns malformed $Json',
        () async {
      // Arrange
      final request =
          Right<InterceptorFailure, NetworkRequest>(_FakeNetworkRequest());
      final malformedJson = Json.from({});
      when(() => _httpClient.request(request.right))
          .thenAnswer((_) async => malformedJson);
      when(() => _interceptorHandler.onResponse(any()))
          .thenAnswer((_) async => Left(_FakeInterceptorFailure()));
      when(() => _interceptorHandler.onError(any())).thenAnswer(
        (_) async => _FakeNetworkFailure(),
      );
      // Act
      final result = await _requestHandler.executeRequest(request);
      // Assert
      expect(result, isA<Left>());
      expect(result.left, isA<NetworkFailure>());
      verify(() => _httpClient.request(request.right)).called(1);
      verifyNever(() => _interceptorHandler.onResponse(any()));
    });

    test(
        'Should return $Left when $NetworkInterceptorHandler onResponse returns $Left',
        () async {
      // Arrange
      final request =
          Right<InterceptorFailure, NetworkRequest>(_FakeNetworkRequest());
      when(() => _httpClient.request(request.right)).thenAnswer((_) async => {
            'data': '',
            'url': '',
            'statusCode': 200,
            'method': 'get',
            'headers': {'data': ''},
          });
      when(() => _interceptorHandler.onResponse(any()))
          .thenAnswer((_) async => Left(_FakeInterceptorFailure()));
      when(() => _interceptorHandler.onError(any())).thenAnswer(
        (_) async => _FakeNetworkFailure(),
      );
      // Act
      final result = await _requestHandler.executeRequest(request);
      // Assert
      expect(result, isA<Left>());
      expect(result.left, isA<NetworkFailure>());
      verify(() => _httpClient.request(request.right)).called(1);
      verify(() => _interceptorHandler.onResponse(any())).called(1);
    });

    test('Should return $Right when all actions succeed', () async {
      // Arrange
      final request =
          Right<InterceptorFailure, NetworkRequest>(_FakeNetworkRequest());
      when(() => _httpClient.request(request.right)).thenAnswer((_) async => {
            'data': '',
            'url': '',
            'statusCode': 200,
            'method': 'get',
            'headers': {'data': ''},
          });
      final response = _FakeNetworkResponse();
      when(() => _interceptorHandler.onResponse(any()))
          .thenAnswer((_) async => Right(response));
      // Act
      final result = await _requestHandler.executeRequest(request);
      // Assert
      expect(result, isA<Right>());
      expect(result.right, isA<NetworkResponse>());
      verify(() => _httpClient.request(request.right)).called(1);
      verify(() => _interceptorHandler.onResponse(any())).called(1);
    });
  });
}
