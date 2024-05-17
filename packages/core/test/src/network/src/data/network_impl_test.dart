import 'package:core/core.dart';
import 'package:core/src/network/src/data/network_impl.dart';
import 'package:core/src/network/src/data/request_handler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockNetworkRequestHandler extends Mock
    implements NetworkRequestHandler {}

class _FakeNetworkRequest extends Fake implements NetworkRequest {}

class _FakeNetworkResponse extends Fake implements NetworkResponse {}

void main() {
  late NetworkImpl _network;
  late NetworkRequestHandler _requestHandler;
  final baseUrl = 'baseUrl';

  setUp(() {
    _requestHandler = _MockNetworkRequestHandler();
    _network = NetworkImpl(
      url: baseUrl,
      requestHandler: _requestHandler,
    );
  });

  test('Method GET - Should call $NetworkRequestHandler methods', () async {
    await _testTemplate(
      _network.get,
      NetworkRequestMethod.get,
      _requestHandler,
      baseUrl,
    );
  });

  test('Method POST - Should call $NetworkRequestHandler methods', () async {
    await _testTemplate(
      _network.post,
      NetworkRequestMethod.post,
      _requestHandler,
      baseUrl,
    );
  });

  test('Method PUT - Should call $NetworkRequestHandler methods', () async {
    await _testTemplate(
      _network.put,
      NetworkRequestMethod.put,
      _requestHandler,
      baseUrl,
    );
  });

  test('Method PATCH - Should call $NetworkRequestHandler methods', () async {
    await _testTemplate(
      _network.patch,
      NetworkRequestMethod.patch,
      _requestHandler,
      baseUrl,
    );
  });

  test('Method DELETE - Should call $NetworkRequestHandler methods', () async {
    await _testTemplate(
      _network.delete,
      NetworkRequestMethod.delete,
      _requestHandler,
      baseUrl,
    );
  });
}

Future<void> _testTemplate(
    Future<Either<Failure, NetworkResponse>> callback(String endpoint),
    NetworkRequestMethod method,
    NetworkRequestHandler _requestHandler,
    String baseUrl,) async {
  // Arrange
  final endpoint = 'endpoint';
  final request =
      Right<InterceptorFailure, NetworkRequest>(_FakeNetworkRequest());
  final response = _FakeNetworkResponse();
  when(() => _requestHandler.prepareRequest(
        method,
        baseUrl,
        endpoint,
        contentType: any(named: 'contentType'),
        body: any(named: 'body'),
      ),).thenAnswer((_) async => request);

  when(() => _requestHandler.executeRequest(request))
      .thenAnswer((_) async => Right(response));
  // Act
  await callback(endpoint);
  // Assert
  verify(() => _requestHandler.prepareRequest(
        method,
        baseUrl,
        endpoint,
        contentType: any(named: 'contentType'),
        body: any(named: 'body'),
      ),).called(1);
  verify(() => _requestHandler.executeRequest(request)).called(1);
}
