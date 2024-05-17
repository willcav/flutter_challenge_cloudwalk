import 'entities.dart';

class InterceptorFailure {
  final String message;
  final String url;
  final NetworkRequestMethod method;
  final int? statusCode;
  final HttpFailureType? type;
  final Map<String, dynamic>? headers;
  final dynamic body;

  InterceptorFailure({
    required this.message,
    required this.url,
    required this.method,
    this.statusCode,
    this.type,
    this.headers,
    this.body,
  });
}
