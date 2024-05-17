import 'dart:async';

import '../../infra/get_it_driver.dart';

abstract interface class ServiceLocatorDriver {
  static final _instance = GetItDriver();

  static final instance = _instance;

  T call<T extends Object>({
    String? instanceName,
    dynamic param1,
    dynamic param2,
  });

  bool isRegistered<T extends Object>({T? instance, String? instanceName});

  void registerFactory<T extends Object>(T Function() factoryFunc,
      {String? instanceName});

  void registerFactoryWithParams<T extends Object, P1, P2>(
      T Function(P1, P2) factoryFunc,
      {String? instanceName});

  void registerSingleton<T extends Object>(
    T singleton, {
    String? instanceName,
    bool? signalsReady,
    FutureOr Function(T param)? dispose,
  });

  void registerLazySingleton<T extends Object>(T Function() singletonFunc,
      {String? instanceName, FutureOr Function(T param)? dispose});

  Future<void> reset({bool dispose = true});

  FutureOr resetLazySingleton<T extends Object>({
    Object? instance,
    String? instanceName,
    FutureOr Function(Object p1)? disposingFunction,
  });
}
