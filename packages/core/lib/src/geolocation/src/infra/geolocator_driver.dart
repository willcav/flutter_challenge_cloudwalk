import 'package:geolocator/geolocator.dart';

import '../../../../core.dart';
import '../data/interfaces/geolocation_driver.dart';
import '../domain/entities/geolocation_failure.dart';

const String _locationPermissionDeniedMessage = 'Location permission is denied';
const String _locationPermissionDeniedForeverMessage =
    'Location permission is denied forever';
const String _locationPermissionNotDeterminedMessage =
    'Location permission is not determined';

class GeolocatorDriver implements GeolocationDriver {
  bool isServiceEnabled = false;
  LocationPermission permission = LocationPermission.denied;
  Position? lastKnownPosition;

  @override
  Future<Either<Failure, GeoPosition>> getCurrentPosition() async {
    try {
      isServiceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isServiceEnabled) {
        return const Left(
          GeolocationFailure(
            message: 'Location service is disabled',
          ),
        );
      }

      final permissionResult = await checkAndRequestPermission();
      if (permissionResult.isLeft) {
        return Left(permissionResult.left);
      }

      final position = await Geolocator.getCurrentPosition(
          timeLimit: const Duration(seconds: 10),);

      lastKnownPosition = position;

      return Right(
        GeoPosition(
          latitude: position.latitude,
          longitude: position.longitude,
        ),
      );
    } catch (e) {
      if (lastKnownPosition != null) {
        return Right(
          GeoPosition(
            latitude: lastKnownPosition!.latitude,
            longitude: lastKnownPosition!.longitude,
          ),
        );
      }
      return Left(
        GeolocationFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> checkAndRequestPermission() async {
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return const Left(
          GeolocationFailure(
            message: _locationPermissionDeniedMessage,
          ),
        );
      }
    } else if (permission == LocationPermission.deniedForever) {
      return const Left(
        GeolocationFailure(
          message: _locationPermissionDeniedForeverMessage,
        ),
      );
    }

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return const Right(null);
    }

    return const Left(
      GeolocationFailure(
        message: _locationPermissionNotDeterminedMessage,
      ),
    );
  }
}
