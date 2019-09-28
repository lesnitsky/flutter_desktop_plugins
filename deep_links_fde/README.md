# DeepLinks plugin for desktop

⚠️ Flutter desktop plugins API is not yet finalized and may change, so this plugin may not be working at some point. File an issue if it doesn't.

## Installation

`pubspec.yaml`

```pubspec.yaml
...
dependencies:
  connectivity: ^0.4.3
  deep_links_fde:
    git:
      url: git://github.com/lesnitsky/fde_plugins.git
      path: deep_links_fde
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
import 'package:deep_links_fde/deep_links.dart';

final dl = new DeepLinks();

dl.onLinkReceived.listen((link) {
  print(link);
});
```
