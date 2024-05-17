import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
  import UIKit
  import Flutter
  import GoogleMaps

  @UIApplicationMain
  @objc class AppDelegate: FlutterAppDelegate {
    override func application(
      _ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
      // Hardcoding API keys in the code is not a recommended practice for production apps.
      // It's done here for the sake of simplicity in this challenge/demo app.
      //
      // In a production environment, i would recommended to:
      // - Store the API key securely on a server and retrieve it at runtime.
      // - Or, store it in a secure local configuration file that's not included in version control.
      // - Use obfuscation tools to prevent reverse engineering of the app.
      //
      // Security is paramount in a production environment.
      GMSServices.provideAPIKey("AIzaSyD2s6HoOsQ6sTVqtgc3ZP9TkeWM-zE86EU")
      GeneratedPluginRegistrant.register(with: self)
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
  }
    GMSServices.provideAPIKey("AIzaSyD2s6HoOsQ6sTVqtgc3ZP9TkeWM-zE86EU")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
