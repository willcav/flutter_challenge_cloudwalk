import 'package:core/core.dart';

class ResourcesInitialization {
  static Future<void> initialize() async {
    await CorePackages().initialize();
  }
}
