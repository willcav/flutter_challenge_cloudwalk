import 'package:core/core.dart';
import 'package:core/src/geolocation/src/data/interfaces/geolocation_driver.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockGeolocationDriver extends Mock implements GeolocationDriver {}

void main() {
  late _MockGeolocationDriver _driver;
  late GeolocationService _service;

  setUp(() {
    _driver = _MockGeolocationDriver();
    _service = GeolocationService(_driver);
  });

  group('Method - getCurrentPosition', () {
    test('Should return a $Left when driver fails', () async {
      when(() => _driver.getCurrentPosition()).thenAnswer(
        (_) async => Left(
          GenericFailure(),
        ),
      );

      final result = await _service.getCurrentPosition();

      expect(result, isA<Left>());
      verify(() => _driver.getCurrentPosition()).called(1);
    });

    test('Should return a $Right $GeoPosition when driver succeeds', () async {
      when(() => _driver.getCurrentPosition()).thenAnswer(
        (_) async => Right(
          GeoPosition(
            latitude: 0,
            longitude: 0,
          ),
        ),
      );

      final result = await _service.getCurrentPosition();

      expect(result, isA<Right>());
      expect(result.right, isA<GeoPosition>());
      verify(() => _driver.getCurrentPosition()).called(1);
    });
  });

  group('Method - checkAndRequestPermission', () {
    test('Should return a $Left when driver fails', () async {
      when(() => _driver.checkAndRequestPermission()).thenAnswer(
        (_) async => Left(
          GenericFailure(),
        ),
      );

      final result = await _service.checkAndRequestPermission();

      expect(result, isA<Left>());
      verify(() => _driver.checkAndRequestPermission()).called(1);
    });

    test('Should return a $Right when driver succeeds', () async {
      when(() => _driver.checkAndRequestPermission()).thenAnswer(
        (_) async => Right(null),
      );

      final result = await _service.checkAndRequestPermission();

      expect(result, isA<Right>());
      verify(() => _driver.checkAndRequestPermission()).called(1);
    });
  });
}
