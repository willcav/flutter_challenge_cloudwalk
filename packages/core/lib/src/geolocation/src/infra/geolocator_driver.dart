import 'package:core/core.dart';
import 'package:geolocator/geolocator.dart';

import '../data/interfaces/geolocation_driver.dart';
import '../domain/entities/geo_position.dart';
import '../domain/entities/geolocation_failure.dart';

const String _locationPermissionDeniedMessage = 'Location permission is denied';
const String _locationPermissionDeniedForeverMessage =
    'Location permission is denied forever';
const String _locationPermissionNotDeterminedMessage =
    'Location permission is not determined';

class GeolocatorDriver implements GeolocationDriver {
  bool isServiceEnabled = false;
  LocationPermission permission = LocationPermission.denied;

  @override
  Future<Either<Failure, GeoPosition>> getCurrentPosition() async {
    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      return Left(GeolocationFailure(
        message: 'Location service is disabled',
      ));
    }

    final permissionResult = await checkAndRequestPermission();
    if (permissionResult.isLeft) {
      return Left(permissionResult.left);
    }

    final position = await Geolocator.getCurrentPosition();
    return Right(
      GeoPosition(
        latitude: position.latitude,
        longitude: position.longitude,
      ),
    );
  }

  @override
  Future<Either<Failure, void>> checkAndRequestPermission() async {
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return Right(null);
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Left(GeolocationFailure(
          message: _locationPermissionDeniedMessage,
        ));
      }
    } else if (permission == LocationPermission.deniedForever) {
      return Left(
        GeolocationFailure(
          message: _locationPermissionDeniedForeverMessage,
        ),
      );
    }

    return Left(GeolocationFailure(
      message: _locationPermissionNotDeterminedMessage,
    ));
  }
}
