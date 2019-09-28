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
      selector: #selector(self.onLinkReceived(_:)),
      name: DeepLinksPlugin.linkReceived,
      object: nil)

    return nil
  }

  public func onCancel(withArguments _: Any?) -> FlutterError? {
    NotificationCenter.default.removeObserver(self)
    eventSink = nil
    return nil
  }
}
