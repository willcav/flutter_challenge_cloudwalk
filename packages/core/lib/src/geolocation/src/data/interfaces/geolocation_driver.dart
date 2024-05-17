import '../../../../../core.dart';

abstract interface class GeolocationDriver {
  Future<Either<Failure, GeoPosition>> getCurrentPosition();

  Future<Either<Failure, void>> checkAndRequestPermission();
}
