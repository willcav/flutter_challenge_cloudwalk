import '../../../../abstractions/failure.dart';

class GeolocationFailure implements Failure {
  const GeolocationFailure({
    this.message,
  });

  @override
  final String? message;
}
