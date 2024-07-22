import 'dart:async';

import 'package:core/core.dart';

import 'src/data/datasources/map_datasource_impl.dart';
import 'src/data/interfaces/map_datasource.dart';
import 'src/data/map_repository_impl.dart';
import 'src/domain/interfaces/map_repository.dart';
import 'src/domain/usecases/get_location_usecase.dart';
import 'src/presentation/map_viewmodel.dart';

class MapFeature implements CommonFeature {
  @override
  FutureOr<void> initialize() {
    const baseUrl = 'http://ip-api.com';

    SL.I.registerFactory<MapDataSource>(
      () => MapDataSourceImpl(Network(baseUrl)),
    );

    SL.I.registerFactory<MapRepository>(
      () => MapRepositoryImpl(
        geolocationService: SL.I<GeolocationService>(),
        mapDataSource: SL.I<MapDataSource>(),
      ),
    );

    SL.I.registerFactory<GetLocationUseCase>(
      () => GetLocationUseCase(SL.I<MapRepository>()),
    );

    SL.I.registerFactory<MapViewModel>(
      () => MapViewModel(SL.I<GetLocationUseCase>()),
    );
  }
}
