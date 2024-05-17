import 'package:core/core.dart';

import '../data/interfaces/geolocation_driver.dart';
import 'entities/geo_position.dart';

class GeolocationService {
  final GeolocationDriver driver;

  GeolocationService(this.driver);

  Future<Either<Failure, GeoPosition>> getCurrentPosition() =>
      driver.getCurrentPosition();

  Future<Either<Failure, void>> checkAndRequestPermission() async =>
      driver.checkAndRequestPermission();
}
