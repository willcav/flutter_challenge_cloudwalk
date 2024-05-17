import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';

enum HttpFailureType {
  // Status code related failures
  badRequest('400'),
  unauthorized('401'),
  forbidden('403'),
  notFound('404'),
  timeout('408'),
  serverError('500'),

  // When the api takes more time than the defined in the httpClient
  receiveTimeout('timeout'),

  // Default failure
  unknown('');

  const HttpFailureType(this.value);

  final String value;
}

class NetworkFailure implements Failure {
  @override
  final String? message;
  final int? statusCode;
  HttpFailureType? _type;

  NetworkFailure({
    HttpFailureType? type,
    this.message,
    this.statusCode,
  }) : _type = type;

  HttpFailureType get type => _type != null ? _type! : typeFromStatusCode;

  @visibleForTesting
  HttpFailureType get typeFromStatusCode {
    switch (statusCode) {
      case 400:
        return HttpFailureType.badRequest;
      case 401:
        return HttpFailureType.unauthorized;
      case 403:
        return HttpFailureType.forbidden;
      case 404:
        return HttpFailureType.notFound;
      case 408:
        return HttpFailureType.timeout;
      case 500:
        return HttpFailureType.serverError;
      default:
        return HttpFailureType.unknown;
    }
  }

  NetworkFailure copyWith({
    String? message,
    int? statusCode,
    HttpFailureType? type,
  }) {
    return NetworkFailure(
      message: message ?? this.message,
      statusCode: statusCode ?? this.statusCode,
      type: type ?? this._type,
    );
  }
}
