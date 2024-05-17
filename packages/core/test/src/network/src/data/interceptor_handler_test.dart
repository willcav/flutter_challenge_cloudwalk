import 'package:core/core.dart';
import 'package:core/src/network/src/data/interceptor_handler.dart';
import 'package:core/src/network/src/domain/interfaces/network_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockINetworkInterceptor extends Mock implements NetworkInterceptor {}

class _MockNetworkRequest extends Mock implements NetworkRequest {}

class _MockNetworkResponse extends Mock implements NetworkResponse {}

void main() {
  late NetworkInterceptor _interceptor;
  late List<NetworkInterceptor> _interceptors;
  late NetworkInterceptorHandler _handler;

  setUp(() {
    _interceptor = _MockINetworkInterceptor();
    _interceptors = [_interceptor];
    _handler = NetworkInterceptorHandler(interceptors: _interceptors);
  });

  setUpAll(() {
    registerFallbackValue(_MockNetworkRequest());
    registerFallbackValue(_MockNetworkResponse());
  });

  group('Method intercept -', () {
    test(
        'Should return $Left when any of the [onRequest] from interceptors in the list fails',
        () async {
      when(() => _interceptor.onRequest(any())).thenAnswer(
        (_) async => const Left(
          InterceptorFailure(
            message: 'message',
            url: 'url',
            method: NetworkRequestMethod.get,
          ),
        ),
      );

      final result = await _handler.intercept<NetworkRequest>(
        input: _MockNetworkRequest(),
        interceptorCall: (interceptor, interceptedRequest) =>
            interceptor.onRequest(interceptedRequest),
        copyWithCallback: (interceptedRequest, updatedRequest) =>
            _MockNetworkRequest(),
      );

      expect(result.isLeft, true);
      expect(result.left, isA<InterceptorFailure>());
    });

    test(
        'Should return $Left when any of the [onResponse] from interceptors in the list fails',
        () async {
      when(() => _interceptor.onResponse(any())).thenAnswer(
        (_) async => const Left(
          InterceptorFailure(
            message: 'message',
            url: 'url',
            method: NetworkRequestMethod.get,
          ),
        ),
      );

      final result = await _handler.intercept<NetworkResponse>(
        input: _MockNetworkResponse(),
        interceptorCall: (interceptor, interceptedResponse) =>
            interceptor.onResponse(interceptedResponse),
        copyWithCallback: (interceptedResponse, updatedResponse) =>
            _MockNetworkResponse(),
      );

      expect(result.isLeft, true);
      expect(result.left, isA<InterceptorFailure>());
    });

    test(
        'Should return $Right when all of the [onRequest] from interceptors succeed',
        () async {
      when(() => _interceptor.onRequest(any())).thenAnswer(
        (_) async => Right(_MockNetworkRequest()),
      );

      final result = await _handler.intercept<NetworkRequest>(
        input: _MockNetworkRequest(),
        interceptorCall: (interceptor, interceptedRequest) =>
            interceptor.onRequest(interceptedRequest),
        copyWithCallback: (interceptedRequest, updatedRequest) =>
            _MockNetworkRequest(),
      );

      expect(result.isRight, true);
      expect(result.right, isA<NetworkRequest>());
    });

    test(
        'Should return $Right when all of the [onResponse] from interceptors succeed',
        () async {
      when(() => _interceptor.onResponse(any())).thenAnswer(
        (_) async => Right(_MockNetworkResponse()),
      );

      final result = await _handler.intercept<NetworkResponse>(
        input: _MockNetworkResponse(),
        interceptorCall: (interceptor, interceptedResponse) =>
            interceptor.onResponse(interceptedResponse),
        copyWithCallback: (interceptedResponse, updatedResponse) =>
            _MockNetworkResponse(),
      );

      expect(result.isRight, true);
      expect(result.right, isA<NetworkResponse>());
    });
  });

  group('Method onRequest -', () {
    test('Should return $Left when [intercept] fails', () async {
      when(() => _interceptor.onRequest(any())).thenAnswer(
        (_) async => const Left(
          InterceptorFailure(
            message: 'message',
            url: 'url',
            method: NetworkRequestMethod.get,
          ),
        ),
      );

      final result = await _handler.onRequest(_MockNetworkRequest());

      expect(result.isLeft, true);
      expect(result.left, isA<InterceptorFailure>());
    });

    test('Should return $Right when [intercept] succeeds', () async {
      final request = _MockNetworkRequest();
      when(() => _interceptor.onRequest(any())).thenAnswer(
        (_) async => Right(request),
      );
      when(() => request.url).thenReturn('url');
      when(() => request.method).thenReturn(NetworkRequestMethod.get);
      when(() => request.body).thenReturn({});
      when(() => request.contentType).thenReturn(NetworkContentType.json);
      when(() => request.responseType).thenReturn(NetworkResponseType.json);
      when(() => request.headers).thenReturn({});
      when(() => request.queryParameters).thenReturn({});
      when(() => request.timeout).thenReturn(Duration.zero);
      when(() => request.copyWith(
            url: any(named: 'url'),
            method: any(named: 'method'),
            body: any(named: 'body'),
            contentType: any(named: 'contentType'),
            responseType: any(named: 'responseType'),
            headers: any(named: 'headers'),
            queryParameters: any(named: 'queryParameters'),
            timeout: any(named: 'timeout'),
          ),).thenReturn(request);

      final result = await _handler.onRequest(request);

      expect(result.isRight, true);
      expect(result.right, isA<NetworkRequest>());
    });
  });

  group('Method onResponse -', () {
    test('Should return $Left when [intercept] fails', () async {
      when(() => _interceptor.onResponse(any())).thenAnswer(
        (_) async => const Left(
          InterceptorFailure(
            message: 'message',
            url: 'url',
            method: NetworkRequestMethod.get,
          ),
        ),
      );

      final result = await _handler.onResponse(_MockNetworkResponse());

      expect(result.isLeft, true);
      expect(result.left, isA<InterceptorFailure>());
    });

    test('Should return $Right when [intercept] succeeds', () async {
      final response = _MockNetworkResponse();
      when(() => _interceptor.onResponse(any())).thenAnswer(
        (_) async => Right(response),
      );
      when(() => response.getData()).thenReturn({});
      when(() => response.url).thenReturn('url');
      when(() => response.statusCode).thenReturn(200);
      when(() => response.method).thenReturn(NetworkRequestMethod.get);
      when(() => response.headers).thenReturn({});
      when(
        () => response.copyWith(
          url: any(named: 'url'),
          statusCode: any(named: 'statusCode'),
          method: any(named: 'method'),
          headers: any(named: 'headers'),
          data: any(named: 'data'),
        ),
      ).thenReturn(response);

      final result = await _handler.onResponse(response);

      expect(result.isRight, true);
      expect(result.right, isA<NetworkResponse>());
    });
  });
}
