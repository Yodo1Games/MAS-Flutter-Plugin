import Flutter
import UIKit

public class SwiftTestmasfluttersdktwoPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "testmasfluttersdktwo", binaryMessenger: registrar.messenger())
    let instance = SwiftTestmasfluttersdktwoPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
