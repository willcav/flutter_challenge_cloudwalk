import 'dart:async';

import '../../data/interfaces/service_locator_driver.dart';
import '../../data/service_locator_impl.dart';

typedef SL = ServiceLocator;

abstract interface class ServiceLocator {
  static final ServiceLocator _instance =
      ServiceLocatorImpl(ServiceLocatorDriver.instance);

  static final I = _instance;

  static final instance = _instance;

  /// Retrieves or creates an instance of the given type [T]
  T call<T extends Object>({
    String? instanceName,
    dynamic param1,
    dynamic param2,
  });

  /// Checks if an instance of the given type [T] is registered
  bool isRegistered<T extends Object>({T? instance, String? instanceName});

  /// Registers a type [T] so that a new instance is created each time it is requested
  void registerFactory<T extends Object>(
    T Function() factoryFunc, {
    String? instanceName,
  });

  /// Registers a type [T] so that a new instance is created each time it is requested
  /// based on up to two parameters provided by [call] method
  void registerFactoryWithParams<T extends Object, P1, P2>(
    T Function(P1, P2) factoryFunc, {
    String? instanceName,
  });

  /// Registers a type [T] as Singleton by passing an instance of that type
  void registerSingleton<T extends Object>(
    T singleton, {
    String? instanceName,
    bool? signalsReady,
    FutureOr Function(T param)? dispose,
  });

  /// Registers a type [T] as Singleton by passing a factory function
  /// that will be called on the first time the instance is requested
  void registerLazySingleton<T extends Object>(
    T Function() singletonFunc, {
    String? instanceName,
    FutureOr Function(T param)? dispose,
  });

  /// Clears all registered types
  Future<void> reset({bool dispose = true});

  /// Clears the instance of a lazy singleton
  FutureOr resetLazySingleton<T extends Object>({
    Object? instance,
    String? instanceName,
    FutureOr Function(Object param)? disposingFunction,
  });
}
