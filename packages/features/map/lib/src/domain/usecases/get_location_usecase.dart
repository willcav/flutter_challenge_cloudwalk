import 'package:core/core.dart';
import '../entities/location_info.dart';
import '../interfaces/map_repository.dart';

class GetLocationUseCase {
  final MapRepository _repository;

  GetLocationUseCase(this._repository);

  Future<Either<Failure, LocationInfo>> call() => _repository.getLocation();
}
