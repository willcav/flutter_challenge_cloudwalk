import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:map/src/data/interfaces/map_datasource.dart';
import 'package:map/src/data/map_repository_impl.dart';
import 'package:map/src/domain/entities/location_info.dart';
import 'package:mocktail/mocktail.dart';

class _MockGeolocationService extends Mock implements GeolocationService {}

class _MockMapDataSource extends Mock implements MapDataSource {}

void main() {
  late GeolocationService _locationService;
  late MapDataSource _dataSource;
  late MapRepositoryImpl _repository;

  setUp(() {
    _locationService = _MockGeolocationService();
    _dataSource = _MockMapDataSource();
    _repository = MapRepositoryImpl(
      geolocationService: _locationService,
      mapDataSource: _dataSource,
    );
  });

  group('Method - getLocation', () {
    test('Should return $Left when both services fail', () async {
      when(() => _locationService.getCurrentPosition()).thenAnswer(
        (_) async => const Left(GenericFailure()),
      );

      when(() => _dataSource.getIPLocation()).thenAnswer(
        (_) async => const Left(GenericFailure()),
      );

      final result = await _repository.getLocation();

      expect(result.isLeft, true);
      expect(result.left, isA<Failure>());
    });

    test('Should return IP Location when location service fails', () async {
      when(() => _locationService.getCurrentPosition()).thenAnswer(
        (_) async => const Left(GenericFailure()),
      );

      when(() => _dataSource.getIPLocation()).thenAnswer(
        (_) async => Right(
          NetworkResponse(
            {'lat': 0.0, 'lon': 0.0},
            url: '',
            statusCode: 200,
            method: NetworkRequestMethod.get,
            headers: {},
          ),
        ),
      );

      final result = await _repository.getLocation();

      expect(result.isRight, true);
      expect(result.right, isA<LocationInfo>());
      expect(result.right.longitude, 0.0);
      expect(result.right.latitude, 0.0);
    });

    test('Should return IP Location when location service fails', () async {
      when(() => _locationService.getCurrentPosition()).thenAnswer(
        (_) async => Right(
          GeoPosition(
            latitude: 0.0,
            longitude: 0.0,
          ),
        ),
      );

      final result = await _repository.getLocation();

      expect(result.isRight, true);
      expect(result.right, isA<LocationInfo>());
      expect(result.right.longitude, 0.0);
      expect(result.right.latitude, 0.0);
    });
  });
}
