import Cocoa
import FlutterMacOS

public class DeepLinksPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
  static let linkReceived = Notification.Name(rawValue: "linkReceived")

  var eventSink: FlutterEventSink?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let streamChannel = FlutterEventChannel(
      name: "plugins.lesnitsky.com/deep_links",
      binaryMessenger: registrar.messenger
    )

    let instance = DeepLinksPlugin()
    streamChannel.setStreamHandler(instance)
  }

  @objc func onLinkReceived(_ notification: NSNotification) {
    let userInfo = notification.userInfo as? [String: URL]
    let link = userInfo?["link"]

    eventSink?(link?.absoluteString)
  }

  public func onListen(
    withArguments _: Any?,
    eventSink events: @escaping FlutterEventSink
  ) -> FlutterError? {
    eventSink = events

    NotificationCenter.default.addObserver(
      self,
      selector: #selector(onLinkReceived(_:)),
      name: DeepLinksPlugin.linkReceived,
      object: nil
    )

    return nil
  }

  public func onCancel(withArguments _: Any?) -> FlutterError? {
    NotificationCenter.default.removeObserver(self)
    eventSink = nil
    return nil
  }
}
