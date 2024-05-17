import 'package:dio/dio.dart';

import '../data/interfaces/network_http_client.dart';
import '../domain/entities/entities.dart';

class DioClient implements NetworkHttpClient {
  final Dio _dio;

  DioClient(this._dio);

  @override
  Future<Map<String, dynamic>> request(NetworkRequest request) async {
    try {
      final options = Options(
        contentType: request.contentType?.name,
        headers: request.headers,
        responseType: request.responseType?.toDioType(),
        receiveTimeout: request.timeout,
      );

      switch (request.method) {
        case NetworkRequestMethod.get:
          return (await _dio.get(
            request.url,
            queryParameters: request.queryParameters,
            options: options,
          ))
              .toMap();
        case NetworkRequestMethod.post:
          return (await _dio.post(
            request.url,
            queryParameters: request.queryParameters,
            data: request.body,
            options: options,
          ))
              .toMap();
        case NetworkRequestMethod.put:
          return (await _dio.post(
            request.url,
            queryParameters: request.queryParameters,
            data: request.body,
            options: options,
          ))
              .toMap();
        case NetworkRequestMethod.patch:
          return (await _dio.post(
            request.url,
            queryParameters: request.queryParameters,
            data: request.body,
            options: options,
          ))
              .toMap();
        case NetworkRequestMethod.delete:
          return (await _dio.post(
            request.url,
            queryParameters: request.queryParameters,
            options: options,
          ))
              .toMap();
      }
    } on DioException catch (error) {
      throw error.toNetworkFailure();
    }
  }
}

extension on NetworkResponseType {
  ResponseType toDioType() {
    switch (this) {
      case NetworkResponseType.json:
        return ResponseType.json;
      case NetworkResponseType.plain:
        return ResponseType.plain;
      case NetworkResponseType.bytes:
        return ResponseType.bytes;
      case NetworkResponseType.stream:
        return ResponseType.stream;
    }
  }
}

extension on Response {
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "url": realUri.host + realUri.path,
      "method": requestOptions.method,
      "headers": requestOptions.headers,
      "statusCode": statusCode,
      "data": data,
    };
  }
}

extension on DioException {
  NetworkFailure toNetworkFailure() {
    switch (this.type) {
      case DioExceptionType.receiveTimeout:
        return NetworkFailure(
          type: HttpFailureType.receiveTimeout,
          message: this.message,
        );
      default:
        final statusCode = this.response?.toMap()['statusCode'];
        return NetworkFailure(
          statusCode: statusCode,
          message: this.message,
        );
    }
  }
}
