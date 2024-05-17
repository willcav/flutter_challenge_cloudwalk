import '../../../abstractions/abstractions.dart';
import '../domain/entities/entities.dart';
import 'interceptor_handler.dart';
import 'interfaces/network_http_client.dart';

class NetworkRequestHandler {
  NetworkRequestHandler({
    required this.httpClient,
    required this.interceptorHandler,
  });

  final NetworkHttpClient httpClient;
  final NetworkInterceptorHandler interceptorHandler;

  Future<Either<InterceptorFailure, NetworkRequest>> prepareRequest(
    NetworkRequestMethod requestMethod,
    String baseUrl,
    String endpoint, {
    body,
    NetworkContentType? contentType,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    NetworkResponseType? responseType,
  }) async {
    final url = '$baseUrl$endpoint';

    // The timeout can be defined in a remote configuration
    const timeout = Duration(seconds: 30);

    final request = NetworkRequest(
      url: url,
      method: requestMethod,
      body: body,
      contentType: contentType,
      responseType: responseType,
      headers: headers,
      queryParameters: queryParameters,
      timeout: timeout,
    );
    return await interceptorHandler.onRequest(request);
  }

  Future<Either<NetworkFailure, NetworkResponse>> executeRequest(
    Either<InterceptorFailure, NetworkRequest> request,
  ) async {
    try {
      if (request.isLeft) throw request.left;

      final result = await httpClient.request(request.right);

      final response = NetworkResponse.fromJson(result);

      final interceptedResponse = await interceptorHandler.onResponse(response);

      if (interceptedResponse.isLeft) throw interceptedResponse.left;

      return Right(interceptedResponse.right);
    } catch (exception) {
      return Left(
        await _handleFailure(exception),
      );
    }
  }

  Future<NetworkFailure> _handleFailure(Object failure) async {
    var networkFailure;

    // Handle a request/response interceptor failure
    if (failure is InterceptorFailure) {
      networkFailure = NetworkFailure(
        type: failure.type,
        statusCode: failure.statusCode,
        message: failure.message,
      );
    }
    // Handle a HttpClient failure
    else if (failure is NetworkFailure) {
      networkFailure = failure;
    }
    // Handle any other failure context
    else {
      networkFailure = NetworkFailure(message: failure.toString());
    }

    return await interceptorHandler.onError(networkFailure);
  }
}
