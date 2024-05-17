import 'dart:async';

import '../domain/interfaces/service_locator.dart';
import 'interfaces/service_locator_driver.dart';

class ServiceLocatorImpl implements ServiceLocator {
  const ServiceLocatorImpl(this._driver);

  final ServiceLocatorDriver _driver;

  @override
  T call<T extends Object>({String? instanceName, param1, param2}) =>
      _driver<T>(
        instanceName: instanceName,
        param1: param1,
        param2: param2,
      );

  @override
  bool isRegistered<T extends Object>({T? instance, String? instanceName}) {
    _assert<T>();
    return _driver.isRegistered<T>(
      instance: instance,
      instanceName: instanceName,
    );
  }

  @override
  void registerFactory<T extends Object>(T Function() factoryFunc,
      {String? instanceName}) {
    _assert<T>();
    return _driver.registerFactory<T>(
      factoryFunc,
      instanceName: instanceName,
    );
  }

  @override
  void registerFactoryWithParams<T extends Object, P1, P2>(
      T Function(P1 p1, P2 p2) factoryFunc,
      {String? instanceName}) {
    _assert<T>();
    return _driver.registerFactoryWithParams<T, P1, P2>(
      factoryFunc,
      instanceName: instanceName,
    );
  }

  @override
  void registerLazySingleton<T extends Object>(T Function() singletonFunc,
      {String? instanceName, FutureOr Function(T param)? dispose}) {
    _assert<T>();
    return _driver.registerLazySingleton<T>(
      singletonFunc,
      instanceName: instanceName,
      dispose: dispose,
    );
  }

  @override
  void registerSingleton<T extends Object>(T singleton,
      {String? instanceName,
      bool? signalsReady,
      FutureOr Function(T param)? dispose}) {
    _assert<T>();
    return _driver.registerSingleton<T>(
      singleton,
      instanceName: instanceName,
      signalsReady: signalsReady,
      dispose: dispose,
    );
  }

  @override
  Future<void> reset({bool dispose = true}) => _driver.reset(dispose: dispose);

  @override
  FutureOr resetLazySingleton<T extends Object>(
      {Object? instance,
      String? instanceName,
      FutureOr Function(Object param)? disposingFunction}) {
    _assert<T>();
    return _driver.resetLazySingleton<T>(
      instance: instance,
      instanceName: instanceName,
      disposingFunction: disposingFunction,
    );
  }

  /// Ensures that registrations and resets are being done in valid types
  void _assert<T>() {
    assert(T != dynamic, 'Type must be specified');
  }
}
