import 'package:core/core.dart';
import 'package:map/src/domain/entities/location_info.dart';
import 'package:map/src/domain/interfaces/map_repository.dart';

class GetLocationUseCase {
  final MapRepository _repository;

  GetLocationUseCase(this._repository);

  Future<Either<Failure, LocationInfo>> call() => _repository.getLocation();
}
