import 'dart:io';

import '../../../abstractions/abstractions.dart';
import '../domain/entities/entities.dart';
import '../domain/interfaces/network_interceptor.dart';

class ConnectivityInterceptor implements NetworkInterceptor {
  ConnectivityInterceptor(this.lookupHandler);

  /// Prefer using [InternetAddress.lookup] function
  final Future<List<InternetAddress>> Function(String host) lookupHandler;

  @override
  Future<Either<InterceptorFailure, NetworkRequest>> onRequest(
      NetworkRequest request,) async {
    try {
      final result = await lookupHandler('google.com').timeout(
        request.timeout ?? const Duration(seconds: 30),
      );
      if (result.isEmpty) {
        throw Failure;
      }
      return Right(request);
    } catch (e) {
      return Left(
        InterceptorFailure(
          message: 'No Connection',
          url: request.url,
          method: request.method,
        ),
      );
    }
  }

  @override
  Future<Either<InterceptorFailure, NetworkResponse>> onResponse(
          NetworkResponse response,) async =>
      Right(response);

  @override
  Future<NetworkFailure> onError(NetworkFailure failure) async => failure;
}
