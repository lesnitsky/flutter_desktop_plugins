import Cocoa
import FlutterMacOS

public class LocalNotificationsPlugin: NSObject, FlutterPlugin, FlutterStreamHandler, NSUserNotificationCenterDelegate {
  private var notificationCenter: NSUserNotificationCenter
  private var eventSink: FlutterEventSink?
  private var replyInputPlaceholderText: String

  override init() {
    notificationCenter = NSUserNotificationCenter.default
    replyInputPlaceholderText = "Reply"
  }

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "plugins.lesnitsky.com/local_notifications_method_channel",
      binaryMessenger: registrar.messenger
    )

    let stream = FlutterEventChannel(
      name: "plugins.lesnitsky.com/local_notifications_event_channel",
      binaryMessenger: registrar.messenger
    )

    let instance = LocalNotificationsPlugin()

    stream.setStreamHandler(instance)
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func userNotificationCenter(_ center: NSUserNotificationCenter, didActivate notification: NSUserNotification) {

    var responseText: String?

    switch (notification.activationType) {
    case .replied:
      guard let response = notification.response else { return }
      responseText = response.string
    default:
      break;
    }

    let json = try? JSONSerialization.data(
      withJSONObject: [
        "id": notification.identifier,
        "response": responseText
    ])

    guard let data = json else { return }

    eventSink?(String(data: data, encoding: String.Encoding.utf8))
  }

  public func handle(_ call: FlutterMethodCall, result: FlutterResult) {
    switch call.method {
    case "sendNotification":
      sendNotification(call, result: result)

    case "setReplyInputPlaceholderText":
      setReplyInputPlaceholderText(call, result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func sendNotification(_ call: FlutterMethodCall, result: FlutterResult) {
    let args = call.arguments as! NSDictionary

    let notification = NSUserNotification()

    for (key,value) in args {
      switch key as! String {
      case "id":
        notification.identifier = value as? String
      case "title":
        notification.title = value as? String;

      case "subtitle":
        notification.subtitle = value as? String

      case "text":
        notification.informativeText = value as? String

      case "imageUrl":
        guard let imageUrl = value as? String else {
          return result(
            FlutterError(
              code: "NO_IMAGE_URL",
              message: "Image url is required",
              details: nil
            )
          )
        }

        guard let url = URL(string: imageUrl) else {
          return result(
            FlutterError(
              code: "INVALID_IMAGE_URL",
              message: "\(value) is invalid URL",
              details: nil
            )
          )
        }

        notification.contentImage = NSImage(contentsOf: url)

      case "requestReply":
        if value as! Bool {
          notification.hasReplyButton = value as! Bool
          notification.responsePlaceholder = replyInputPlaceholderText
        }

      default:
        return result(
          FlutterError(
            code: "UNKNOWN_ARGUMENT",
            message: "Unknown argument \(key)",
            details: nil
          )
        )
      }
    }

    notification.soundName = NSUserNotificationDefaultSoundName
    notificationCenter.deliver(notification)

    result(nil)
  }

  private func setReplyInputPlaceholderText(_ call: FlutterMethodCall, result: FlutterResult) {
    replyInputPlaceholderText = call.arguments as! String
    result(nil)
  }

  public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
    eventSink = events
    notificationCenter.delegate = self

    return nil
  }

  public func onCancel(withArguments arguments: Any?) -> FlutterError? {
    eventSink = nil
    notificationCenter.delegate = nil

    return nil
  }
}
