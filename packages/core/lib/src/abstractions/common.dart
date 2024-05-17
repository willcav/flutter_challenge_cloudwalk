import 'dart:async';

/// Default interface for all packages.
abstract interface class CommonPackage {
  FutureOr<void> initialize();
}

/// Default interface for all features.
abstract interface class CommonFeature implements CommonPackage {}
