import 'package:core/core.dart';

import '../entities/entities.dart';

abstract interface class Network {
  factory Network(String baseUrl) => SL.I<Network>(param1: baseUrl);

  /// The base URL of the API that the application communicates with.
  ///
  /// This URL serves as the starting point for constructing complete URLs for
  /// making HTTP requests to various endpoints within the API or server.
  String get baseUrl;

  Future<Either<NetworkFailure, NetworkResponse>> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    NetworkResponseType? responseType,
  });

  Future<Either<NetworkFailure, NetworkResponse>> post(
    String endpoint, {
    dynamic body,
    NetworkContentType? contentType = NetworkContentType.json,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    NetworkResponseType? responseType,
  });

  Future<Either<NetworkFailure, NetworkResponse>> put(
    String endpoint, {
    dynamic body,
    NetworkContentType? contentType = NetworkContentType.json,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    NetworkResponseType? responseType,
  });

  Future<Either<NetworkFailure, NetworkResponse>> patch(
    String endpoint, {
    dynamic body,
    NetworkContentType? contentType = NetworkContentType.json,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    NetworkResponseType? responseType,
  });

  Future<Either<NetworkFailure, NetworkResponse>> delete(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    NetworkResponseType? responseType,
  });
}
