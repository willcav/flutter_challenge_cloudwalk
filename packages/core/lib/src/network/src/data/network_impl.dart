import 'package:core/src/abstractions/either.dart';
import 'package:core/src/network/src/data/request_handler.dart';

import 'package:core/src/network/src/domain/entities/entities.dart';

import '../domain/interfaces/network.dart';

class NetworkImpl implements Network {
  final String _url;
  final NetworkRequestHandler requestHandler;

  const NetworkImpl({
    required String url,
    required this.requestHandler,
  }) : _url = url;

  @override
  String get baseUrl => _url;

  @override
  Future<Either<NetworkFailure, NetworkResponse>> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    NetworkResponseType? responseType,
  }) async {
    final request = await requestHandler.prepareRequest(
      NetworkRequestMethod.get,
      _url,
      endpoint,
      headers: headers,
      queryParameters: queryParameters,
      responseType: responseType,
    );
    return requestHandler.executeRequest(request);
  }

  @override
  Future<Either<NetworkFailure, NetworkResponse>> post(
    String endpoint, {
    body,
    NetworkContentType? contentType = NetworkContentType.json,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    NetworkResponseType? responseType,
  }) async {
    final request = await requestHandler.prepareRequest(
      NetworkRequestMethod.post,
      _url,
      endpoint,
      contentType: contentType,
      headers: headers,
      body: body,
      queryParameters: queryParameters,
      responseType: responseType,
    );
    return requestHandler.executeRequest(request);
  }

  @override
  Future<Either<NetworkFailure, NetworkResponse>> patch(
    String endpoint, {
    body,
    NetworkContentType? contentType = NetworkContentType.json,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    NetworkResponseType? responseType,
  }) async {
    final request = await requestHandler.prepareRequest(
      NetworkRequestMethod.patch,
      _url,
      endpoint,
      contentType: contentType,
      headers: headers,
      body: body,
      queryParameters: queryParameters,
      responseType: responseType,
    );
    return requestHandler.executeRequest(request);
  }

  @override
  Future<Either<NetworkFailure, NetworkResponse>> put(
    String endpoint, {
    body,
    NetworkContentType? contentType = NetworkContentType.json,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    NetworkResponseType? responseType,
  }) async {
    final request = await requestHandler.prepareRequest(
      NetworkRequestMethod.put,
      _url,
      endpoint,
      contentType: contentType,
      headers: headers,
      body: body,
      queryParameters: queryParameters,
      responseType: responseType,
    );
    return requestHandler.executeRequest(request);
  }

  @override
  Future<Either<NetworkFailure, NetworkResponse>> delete(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    NetworkResponseType? responseType,
  }) async {
    final request = await requestHandler.prepareRequest(
      NetworkRequestMethod.delete,
      _url,
      endpoint,
      headers: headers,
      queryParameters: queryParameters,
      responseType: responseType,
    );
    return requestHandler.executeRequest(request);
  }
}
