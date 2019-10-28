# ApplicationBadge plugin for desktop

[![GitHub stars](https://img.shields.io/github/stars/lesnitsky/flutter_desktop_plugins.svg?style=social)](https://github.com/lesnitsky/flutter_desktop_plugins)
[![Twitter Follow](https://img.shields.io/twitter/follow/lesnitsky_a.svg?label=Follow%20me&style=social)](https://twitter.com/lesnitsky_a)

⚠️ Flutter desktop plugins API is not yet finalized and may change, so this plugin may not be working at some point. File an issue if it doesn't.

![Screenshot](https://screenshots-lesnitsky.s3.eu-west-2.amazonaws.com/flutter_application_badge.png)

## Installation

`pubspec.yaml`

```pubspec.yaml
...
dependencies:
  application_badge:
    git:
      url: git://github.com/lesnitsky/flutter_desktop_plugins.git
      path: application_badge
...
```

## Usage

```dart
import 'package:application_badge/application_badge.dart';

class MyApp extends StatelessWidget {
  /// ...

  setBadge(String badge) async {
    await ApplicationBadge.setBadge('42');
  }

  clearBadge() async P{
    await ApplicationBadge.clear();
  }
}
```
