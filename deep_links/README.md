# DeepLinks plugin for macOS

[![GitHub stars](https://img.shields.io/github/stars/lesnitsky/flutter_desktop_plugins.svg?style=social)](https://github.com/lesnitsky/flutter_desktop_plugins)
[![Twitter Follow](https://img.shields.io/twitter/follow/lesnitsky_dev.svg?label=Follow%20me&style=social)](https://twitter.com/lesnitsky_a)

## Installation

`pubspec.yaml`

```pubspec.yaml
...
dependencies:
  deep_links: ^0.3.0
...
```

> This step won't be necessary when [flutter#41471](https://github.com/flutter/flutter/issues/41471) will be resolved

Add this to your `AppDelegate.swift`

```swift
  override func application(_ application:NSApplication, open urls: [URL]) {
    var data: [String: URL] = [:]
    data["link"] = urls[0]

    NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "linkReceived"), object: nil, userInfo: data));
  }
```

Define your scheme (`Info.plist`)

```xml
	<key>CFBundleURLTypes</key>
	<array>
		<dict>
			<key>CFBundleTypeRole</key>
			<string>Editor</string>
			<key>CFBundleURLSchemes</key>
			<array>
				<string>your_url_scheme</string>
			</array>
		</dict>
	</array>
```

Now you can open `your_url_scheme://somethingsomething` types of urls and these would be sent to your macOS app

👇 Here's how you can handle those in dart

## Usage

```dart
import 'package:deep_links/deep_links.dart';

DeepLinks.instance.onLinkReceived.listen((link) {
  print(link);
});
```
