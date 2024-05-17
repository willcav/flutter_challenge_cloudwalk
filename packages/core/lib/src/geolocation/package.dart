import 'dart:async';

import '../../core.dart';
import 'src/data/interfaces/geolocation_driver.dart';
import 'src/infra/geolocator_driver.dart';

class GeolocationPackage implements CommonPackage {
  @override
  FutureOr<void> initialize() {
    SL.I.registerLazySingleton<GeolocationDriver>(() => GeolocatorDriver());
    SL.I.registerFactory<GeolocationService>(
      () => GeolocationService(SL.I<GeolocationDriver>()),
    );
  }
}
