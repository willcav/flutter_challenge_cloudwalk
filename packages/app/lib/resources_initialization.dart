import 'package:core/core.dart';
import 'package:map/map.dart';

final _features = <CommonFeature>[
  MapFeature(),
];

class ResourcesInitialization {
  static Future<void> initialize() async {
    await CorePackages().initialize();

    for (final feature in _features) {
      await feature.initialize();
    }
  }
}
