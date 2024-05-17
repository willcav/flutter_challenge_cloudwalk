import 'package:core/core.dart';

import '../data/interfaces/map_datasource.dart';

class MapDataSourceImpl implements MapDataSource {
  final Network _network;

  MapDataSourceImpl(this._network);

  @override
  Future<Either<Failure, NetworkResponse>> getIPLocation() =>
      _network.get('/json');
}
