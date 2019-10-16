# DeepLinks plugin for desktop

[![GitHub stars](https://img.shields.io/github/stars/lesnitsky/flutter_desktop_plugins.svg?style=social)](https://github.com/lesnitsky/flutter_desktop_plugins)
[![Twitter Follow](https://img.shields.io/twitter/follow/lesnitsky_a.svg?label=Follow%20me&style=social)](https://twitter.com/lesnitsky_a)

⚠️ Flutter desktop plugins API is not yet finalized and may change, so this plugin may not be working at some point. File an issue if it doesn't.

## Installation

`pubspec.yaml`

```pubspec.yaml
...
dependencies:
  deep_links:
    git:
      url: git://github.com/lesnitsky/flutter_desktop_plugins.git
      path: deep_links
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
