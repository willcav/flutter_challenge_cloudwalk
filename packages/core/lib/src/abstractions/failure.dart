/// Default interface for all failures.
abstract interface class Failure implements Exception {
  String? get message;
}

class GenericFailure implements Failure {
  final String? message;

  const GenericFailure([this.message]);
}
