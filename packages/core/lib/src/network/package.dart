import 'dart:async';
import 'dart:io';

import 'package:core/core.dart';
import 'package:core/src/network/src/data/request_handler.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'src/data/interceptor_handler.dart';
import 'src/data/interfaces/network_http_client.dart';
import 'src/data/network_impl.dart';
import 'src/infra/dio_client.dart';
import 'src/interceptors/connectivity_interceptor.dart';

class NetworkPackage implements CommonPackage {
  @override
  FutureOr<void> initialize() {
    final dio = Dio();

    dio.interceptors.add(PrettyDioLogger());

    SL.I.registerFactory<NetworkHttpClient>(
      () => DioClient(dio),
    );

    SL.I.registerFactory<NetworkInterceptorHandler>(
      () => NetworkInterceptorHandler(
        interceptors: [
          ConnectivityInterceptor(InternetAddress.lookup),
        ],
      ),
    );

    SL.I.registerFactory<NetworkRequestHandler>(
      () => NetworkRequestHandler(
        httpClient: SL.I<NetworkHttpClient>(),
        interceptorHandler: SL.I<NetworkInterceptorHandler>(),
      ),
    );

    SL.I.registerFactoryWithParams<Network, String, void>(
      (baseUrl, _) {
        return NetworkImpl(
          url: baseUrl,
          requestHandler: SL.I<NetworkRequestHandler>(),
        );
      },
    );
  }
}
