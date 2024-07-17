  import UIKit
  import Flutter
  import GoogleMaps

  @UIApplicationMain
  @objc class AppDelegate: FlutterAppDelegate {
    override func application(
      _ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
      if let path = Bundle.main.path(forResource: "Keys", ofType: "plist"),
         let config = NSDictionary(contentsOfFile: path),
         let apiKey = config["GEO_API_KEY"] as? String {
            GMSServices.provideAPIKey(apiKey)
      } else {
          print("API Key not found!")
      }
      GeneratedPluginRegistrant.register(with: self)
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
  }