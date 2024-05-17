import 'src/abstractions/abstractions.dart';

class CorePackages {
  static final packages = <CommonPackage>[];

  Future<void> initialize() async {
    for (final package in packages) {
      await package.initialize();
    }
  }
}
