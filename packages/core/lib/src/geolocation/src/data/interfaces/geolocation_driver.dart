import 'package:core/core.dart';

import '../../domain/entities/geo_position.dart';

abstract interface class GeolocationDriver {
  Future<Either<Failure, GeoPosition>> getCurrentPosition();

  Future<Either<Failure, void>> checkAndRequestPermission();
}
