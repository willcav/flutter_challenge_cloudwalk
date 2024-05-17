import 'dart:async';

import 'package:get_it/get_it.dart';

import '../data/interfaces/service_locator_driver.dart';

class GetItDriver implements ServiceLocatorDriver {
  final _getIt = GetIt.I;

  @override
  T call<T extends Object>({String? instanceName, param1, param2}) => _getIt<T>(
        instanceName: instanceName, param1: param1, param2: param2,);

  @override
  bool isRegistered<T extends Object>({T? instance, String? instanceName}) => _getIt.isRegistered<T>(
        instance: instance, instanceName: instanceName,);

  @override
  void registerFactory<T extends Object>(T Function() factoryFunc,
      {String? instanceName,}) => _getIt.registerFactory<T>(factoryFunc, instanceName: instanceName);

  @override
  void registerFactoryWithParams<T extends Object, P1, P2>(
      T Function(P1, P2) factoryFunc,
      {String? instanceName,}) => _getIt.registerFactoryParam(factoryFunc, instanceName: instanceName);

  @override
  T registerSingleton<T extends Object>(T singleton,
      {String? instanceName,
      bool? signalsReady,
      FutureOr Function(T param)? dispose,}) => _getIt.registerSingleton<T>(singleton,
        instanceName: instanceName,
        signalsReady: signalsReady,
        dispose: dispose,);

  @override
  void registerLazySingleton<T extends Object>(T Function() singletonFunc,
      {String? instanceName, FutureOr Function(T param)? dispose,}) => _getIt.registerLazySingleton<T>(singletonFunc,
        instanceName: instanceName, dispose: dispose,);

  @override
  Future<void> reset({bool dispose = true}) => _getIt.reset(dispose: dispose);

  @override
  FutureOr resetLazySingleton<T extends Object>(
      {Object? instance,
      String? instanceName,
      FutureOr Function(Object p1)? disposingFunction,}) => _getIt.resetLazySingleton(
        instance: instance,
        instanceName: instanceName,
        disposingFunction: disposingFunction,);
}
