import 'src/abstractions/abstractions.dart';
import 'src/geolocation/package.dart';
import 'src/network/package.dart';

class CorePackages {
  static final packages = <CommonPackage>[
    NetworkPackage(),
    GeolocationPackage(),
  ];

  Future<void> initialize() async {
    for (final package in packages) {
      await package.initialize();
    }
  }
}
