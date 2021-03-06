// Copyright 2019 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Cocoa
import CoreWLAN
import FlutterMacOS
import Reachability
import SystemConfiguration.CaptiveNetwork

public class ConnectivityPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
  var reach: Reachability?
  var eventSink: FlutterEventSink?
  var cwinterface: CWInterface?

  public override init() {
    cwinterface = CWWiFiClient.shared().interface()
  }

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "plugins.flutter.io/connectivity",
      binaryMessenger: registrar.messenger)

    let streamChannel = FlutterEventChannel(
      name: "plugins.flutter.io/connectivity_status",
      binaryMessenger: registrar.messenger)

    let instance = ConnectivityPlugin()
    streamChannel.setStreamHandler(instance)

    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "check":
      result(statusFromReachability(reachability: Reachability.forInternetConnection()))
    case "wifiName":
      result(cwinterface?.ssid())
    case "wifiBSSID":
      result(cwinterface?.bssid())
    case "wifiIPAddress":
      result(getWiFiIP())
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  func getWiFiIP() -> String? {
    var ifaddr: UnsafeMutablePointer<ifaddrs>?
    let result = getifaddrs(&ifaddr)

    if result == 0 {
      guard let firstAddr = ifaddr else { return nil }

      for ptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
        let name = String(cString: ptr.pointee.ifa_name)
        let addr = ptr.pointee.ifa_addr.pointee

        if addr.sa_family == UInt8(AF_INET), name == "en0" {
          var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
          if getnameinfo(ptr.pointee.ifa_addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count),
                         nil, socklen_t(0), NI_NUMERICHOST) == 0 {
            let address = String(cString: hostname)
            freeifaddrs(ifaddr)
            return address
          }
        }
      }
    }

    freeifaddrs(ifaddr)

    return nil
  }

  /// Returns a string describing connection type
  ///
  /// - Parameters:
  ///   - reachability: an instance of reachability
  /// - Returns: connection type string
  private func statusFromReachability(reachability: Reachability?) -> String {
    if reachability?.isReachableViaWiFi() ?? false {
      return "wifi"
    } else if reachability?.isReachableViaWWAN() ?? false {
      return "mobile"
    }

    return "none"
  }

  public func onListen(
    withArguments _: Any?,
    eventSink events: @escaping FlutterEventSink
  ) -> FlutterError? {
    reach = Reachability.forInternetConnection()
    eventSink = events

    NotificationCenter.default.addObserver(
      self,
      selector: #selector(reachabilityChanged),
      name: NSNotification.Name.reachabilityChanged,
      object: reach)

    reach?.startNotifier()

    return nil
  }

  @objc private func reachabilityChanged(notification: NSNotification) {
    let reach = notification.object
    let reachability = statusFromReachability(reachability: reach as? Reachability)
    eventSink?(reachability)
  }

  public func onCancel(withArguments _: Any?) -> FlutterError? {
    reach?.stopNotifier()
    NotificationCenter.default.removeObserver(self)
    eventSink = nil
    return nil
  }
}
