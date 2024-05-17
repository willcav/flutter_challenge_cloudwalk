import 'package:core/core.dart';

abstract interface class MapDataSource {
  Future<Either<Failure, NetworkResponse>> getIPLocation();
}
