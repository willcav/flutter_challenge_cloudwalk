import 'dart:async';

/// Default interface for all packages.
abstract interface class CommonPackage {
  /// All the dependencies of the package are registered here.
  FutureOr<void> initialize();
}

/// Default interface for all features.
abstract interface class CommonFeature implements CommonPackage {}
