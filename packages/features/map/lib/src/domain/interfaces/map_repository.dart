import 'package:core/core.dart';

import '../entities/location_info.dart';

abstract interface class MapRepository {
  Future<Either<Failure, LocationInfo>> getLocation();
}
