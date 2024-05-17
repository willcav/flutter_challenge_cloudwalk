import 'package:core/src/service_locator/src/data/interfaces/service_locator_driver.dart';
import 'package:core/src/service_locator/src/data/service_locator_impl.dart';
import 'package:core/src/service_locator/src/domain/interfaces/service_locator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockServiceLocatorDriver extends Mock implements ServiceLocatorDriver {}

/// Dummy Class Used to be registered for test
class TestClassType {}

void main() {
  late ServiceLocatorDriver _serviceLocatorDriver;
  late ServiceLocator _serviceLocator;

  setUp(() {
    _serviceLocatorDriver = _MockServiceLocatorDriver();
    _serviceLocator = ServiceLocatorImpl(_serviceLocatorDriver);
  });

  group('Method call -', () {
    test('Should throw $StateError when $TestClassType is not registered', () {
      // Arrange
      when(() => _serviceLocatorDriver.call<TestClassType>()).thenThrow(
        StateError(''),
      );

      // Act
      final result = _serviceLocator.call<TestClassType>;

      // Assert
      expect(() => result(), throwsA(isA<StateError>()));
      verify(() => _serviceLocatorDriver.call<TestClassType>()).called(1);
    });

    test('Should return an instance of $TestClassType when it is registered',
        () {
      // Arrange
      final testClassType = TestClassType();
      when(() => _serviceLocatorDriver.call<TestClassType>())
          .thenReturn(testClassType);

      // Act
      final result = _serviceLocator.call<TestClassType>();

      // Assert
      expect(result, isA<TestClassType>());
      verify(() => _serviceLocatorDriver.call<TestClassType>()).called(1);
    });
  });

  group('Method isRegistered -', () {
    test('Should return [false] when $TestClassType is not registered', () {
      // Arrange
      when(() => _serviceLocatorDriver.isRegistered<TestClassType>())
          .thenReturn(false);

      // Act
      final result = _serviceLocator.isRegistered<TestClassType>();

      // Assert
      expect(result, false);
      verify(() => _serviceLocatorDriver.isRegistered<TestClassType>())
          .called(1);
    });

    test('Should return [true] when $TestClassType is registered', () {
      // Arrange
      when(() => _serviceLocatorDriver.isRegistered<TestClassType>())
          .thenReturn(true);

      // Act
      final result = _serviceLocator.isRegistered<TestClassType>();

      // Assert
      expect(result, true);
      verify(() => _serviceLocatorDriver.isRegistered<TestClassType>())
          .called(1);
    });
  });

  group('Method registerFactory -', () {
    test(
        'Should throw $ArgumentError when $TestClassType is already registered with same instance name',
        () {
      // Arrange
      final func = () => TestClassType();
      when(() => _serviceLocatorDriver.registerFactory<TestClassType>(func))
          .thenThrow(ArgumentError());

      // Act
      final action = _serviceLocator.registerFactory<TestClassType>;

      // Assert
      expect(() => action(func), throwsA(isA<ArgumentError>()));
      verify(() => _serviceLocatorDriver.registerFactory<TestClassType>(func))
          .called(1);
    });

    test(
        'Should register $TestClassType when instance name is not used or type is not registered',
        () {
      // Arrange
      final func = () => TestClassType();
      when(() => _serviceLocatorDriver.registerFactory<TestClassType>(func))
          .thenReturn(null);

      // Act
      _serviceLocator.registerFactory<TestClassType>(func);

      // Assert
      verify(() => _serviceLocatorDriver.registerFactory<TestClassType>(func))
          .called(1);
    });
  });

  group('Method registerFactoryWithParams -', () {
    test(
        'Should throw $ArgumentError when $TestClassType is already registered with same instance name',
        () {
      // Arrange
      final func = (_, __) => TestClassType();
      when(() => _serviceLocatorDriver
              .registerFactoryWithParams<TestClassType, int, int>(func))
          .thenThrow(ArgumentError());

      // Act
      final action =
          _serviceLocator.registerFactoryWithParams<TestClassType, int, int>;

      // Assert
      expect(() => action(func), throwsA(isA<ArgumentError>()));
      verify(() => _serviceLocatorDriver
          .registerFactoryWithParams<TestClassType, int, int>(func)).called(1);
    });

    test(
        'Should register $TestClassType with params when instance name is not used or type is not registered',
        () {
      // Arrange
      final func = (_, __) => TestClassType();
      when(() => _serviceLocatorDriver
              .registerFactoryWithParams<TestClassType, int, int>(func))
          .thenReturn(null);

      // Act
      _serviceLocator.registerFactoryWithParams<TestClassType, int, int>(func);

      // Assert
      verify(() => _serviceLocatorDriver
          .registerFactoryWithParams<TestClassType, int, int>(func)).called(1);
    });
  });

  group('Method registerSingleton -', () {
    test(
        'Should throw $ArgumentError when $TestClassType is already registered with same instance name',
        () {
      // Arrange
      final testClassType = TestClassType();
      when(() => _serviceLocatorDriver.registerSingleton<TestClassType>(
          testClassType)).thenThrow(ArgumentError());

      // Act
      final action = _serviceLocator.registerSingleton<TestClassType>;

      // Assert
      expect(() => action(testClassType), throwsA(isA<ArgumentError>()));
      verify(() => _serviceLocatorDriver
          .registerSingleton<TestClassType>(testClassType)).called(1);
    });

    test(
        'Should register $TestClassType when instance name is not used or type is not registered',
        () {
      // Arrange
      final testClassType = TestClassType();
      when(() => _serviceLocatorDriver
          .registerSingleton<TestClassType>(testClassType)).thenReturn(null);

      // Act
      _serviceLocator.registerSingleton<TestClassType>(testClassType);

      // Assert
      verify(() => _serviceLocatorDriver
          .registerSingleton<TestClassType>(testClassType)).called(1);
    });
  });

  group('Method registerLazySingleton -', () {
    test(
        'Should throw $ArgumentError when $TestClassType is already registered with same instance name',
        () {
      // Arrange
      final func = () => TestClassType();
      when(() =>
              _serviceLocatorDriver.registerLazySingleton<TestClassType>(func))
          .thenThrow(ArgumentError());

      // Act
      final action = _serviceLocator.registerLazySingleton<TestClassType>;

      // Assert
      expect(() => action(func), throwsA(isA<ArgumentError>()));
      verify(() =>
              _serviceLocatorDriver.registerLazySingleton<TestClassType>(func))
          .called(1);
    });

    test(
        'Should register $TestClassType when instance name is not used or type is not registered',
        () {
      // Arrange
      final func = () => TestClassType();
      when(() =>
              _serviceLocatorDriver.registerLazySingleton<TestClassType>(func))
          .thenReturn(null);

      // Act
      _serviceLocator.registerLazySingleton<TestClassType>(func);

      // Assert
      verify(() =>
              _serviceLocatorDriver.registerLazySingleton<TestClassType>(func))
          .called(1);
    });
  });

  test('Should call reset', () {
    // Arrange
    when(() => _serviceLocatorDriver.reset())
        .thenAnswer((invocation) async => null);

    // Act
    _serviceLocator.reset();

    // Assert
    verify(() => _serviceLocatorDriver.reset()).called(1);
  });

  test('Should reset a lazySingleton', () {
    // Arrange
    final testClassType = TestClassType();
    when(() =>
            _serviceLocatorDriver.resetLazySingleton(instance: testClassType))
        .thenAnswer((invocation) => invocation);

    // Act
    _serviceLocator.resetLazySingleton(instance: testClassType);

    // Assert
    verify(() =>
            _serviceLocatorDriver.resetLazySingleton(instance: testClassType))
        .called(1);
  });
}
