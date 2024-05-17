import 'package:core/core.dart';
import 'package:map/src/data/models/location_info_model.dart';

import '../domain/entities/location_info.dart';
import '../domain/interfaces/map_repository.dart';
import 'interfaces/map_datasource.dart';

const _failedToGetLocation = 'Failed to get location';

class MapRepositoryImpl implements MapRepository {
  final GeolocationService _geolocationService;
  final MapDataSource _mapDataSource;

  MapRepositoryImpl({
    required GeolocationService geolocationService,
    required MapDataSource mapDataSource,
  })  : _geolocationService = geolocationService,
        _mapDataSource = mapDataSource;

  @override
  Future<Either<Failure, LocationInfo>> getLocation() async {
    final location = await _geolocationService.getCurrentPosition();

    if (location.isRight) {
      return Right(
        LocationInfo(
          latitude: location.right.latitude,
          longitude: location.right.longitude,
        ),
      );
    }

    final ipLocation = await _mapDataSource.getIPLocation();
    if (ipLocation.isLeft) {
      return const Left(GenericFailure(_failedToGetLocation));
    }

    return handleIpLocationResponse(ipLocation);
  }

  Either<Failure, LocationInfo> handleIpLocationResponse(
      Either<Failure, NetworkResponse> ipLocation) {
    try {
      final locationInfo =
          LocationInfoModel.fromJson(ipLocation.right.jsonData);
      return Right(locationInfo);
    } catch (e) {
      return const Left(GenericFailure(_failedToGetLocation));
    }
  }
}
