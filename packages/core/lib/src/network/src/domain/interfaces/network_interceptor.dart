import 'package:core/core.dart';
import 'package:core/src/network/src/domain/entities/entities.dart';

abstract interface class NetworkInterceptor {
  /// Method called upon request by the **InterceptorHandler**
  Future<Either<InterceptorFailure, NetworkRequest>> onRequest(
      NetworkRequest request);

  /// Method called after response by the **InterceptorHandler**
  Future<Either<InterceptorFailure, NetworkResponse>> onResponse(
      NetworkResponse response);

  /// Method called after a failure by the **InterceptorHandler**
  Future<NetworkFailure> onError(NetworkFailure failure);
}
