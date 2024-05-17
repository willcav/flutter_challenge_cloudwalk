import '../../domain/entities/entities.dart';

abstract interface class NetworkHttpClient {
  Future<Map<String, dynamic>> request(NetworkRequest request);
}
