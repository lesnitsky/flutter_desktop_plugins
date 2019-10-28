import Cocoa
import FlutterMacOS

public class ApplicationBadgePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "plugins.lesnitsky.com/application_badge_method_channel",
      binaryMessenger: registrar.messenger
    )

    let instance = ApplicationBadgePlugin()

    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: FlutterResult) {
    switch call.method {
    case "setBadge":
       setBadge(call, result: result)
      break

    case "clear":
       clear(call, result: result)
       break;

    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func setBadge(_ call: FlutterMethodCall, result: FlutterResult) {
    NSApplication.shared.dockTile.showsApplicationBadge = true

    let label = (call.arguments as! String)

    NSApplication.shared.dockTile.badgeLabel = label
    result(nil)
  }

  private func clear(_ call: FlutterMethodCall, result: FlutterResult) {
    NSApplication.shared.dockTile.badgeLabel = ""
    result(nil)
  }
}
