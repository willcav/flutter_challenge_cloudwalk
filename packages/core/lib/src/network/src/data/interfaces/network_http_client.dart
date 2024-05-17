import 'package:core/src/network/src/domain/entities/entities.dart';

abstract interface class NetworkHttpClient {
  Future<Map<String, dynamic>> request(NetworkRequest request);
}
