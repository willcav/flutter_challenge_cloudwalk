import 'dart:async';

import 'package:core/core.dart';
import 'package:core/src/geolocation/src/domain/geolocation_service.dart';
import 'package:core/src/geolocation/src/infra/geolocator_driver.dart';

import 'src/data/interfaces/geolocation_driver.dart';

class GeolocationPackage implements CommonPackage {
  @override
  FutureOr<void> initialize() {
    SL.I.registerLazySingleton<GeolocationDriver>(() => GeolocatorDriver());
    SL.I.registerFactory<GeolocationService>(
      () => GeolocationService(SL.I<GeolocationDriver>()),
    );
  }
}
