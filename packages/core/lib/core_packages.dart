import 'src/abstractions/abstractions.dart';
import 'src/network/package.dart';

class CorePackages {
  static final packages = <CommonPackage>[
    NetworkPackage(),
  ];

  Future<void> initialize() async {
    for (final package in packages) {
      await package.initialize();
    }
  }
}
