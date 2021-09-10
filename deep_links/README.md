# DeepLinks plugin for macOS

[![GitHub stars](https://img.shields.io/github/stars/lesnitsky/flutter_desktop_plugins.svg?style=social)](https://github.com/lesnitsky/flutter_desktop_plugins)
[![Twitter Follow](https://img.shields.io/twitter/follow/lesnitsky_dev.svg?label=Follow%20me&style=social)](https://twitter.com/lesnitsky_a)

## Installation

`pubspec.yaml`

```pubspec.yaml
...
dependencies:
  deep_links_macos: ^0.1.0
...
```

This step won't be necessary when [flutter#41471](https://github.com/flutter/flutter/issues/41471) will be resolved

`AppDelegate.swift`

```diff
+  func application(_ application:NSApplication, open urls: [URL]) {
+    var data: [String: URL] = [:]
+    data["link"] = urls[0]
+
+    NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "linkReceived"), object: nil, userInfo: data));
+  }
+
```

## Usage

```dart
import 'package:deep_links/deep_links.dart';

final dl = new DeepLinks();

dl.onLinkReceived.listen((link) {
  print(link);
});
```
