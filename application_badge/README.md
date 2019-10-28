# ApplicationBadge plugin for desktop

[![GitHub stars](https://img.shields.io/github/stars/lesnitsky/flutter_desktop_plugins.svg?style=social)](https://github.com/lesnitsky/flutter_desktop_plugins)
[![Twitter Follow](https://img.shields.io/twitter/follow/lesnitsky_a.svg?label=Follow%20me&style=social)](https://twitter.com/lesnitsky_a)

⚠️ Flutter desktop plugins API is not yet finalized and may change, so this plugin may not be working at some point. File an issue if it doesn't.

![Screenshot](https://screenshots-lesnitsky.s3.eu-west-2.amazonaws.com/flutter_application_badge.jpg)

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

final notification = new Notification(
  id: 'unique-id',
  title: 'Notification sent from flutter',
  subtitle: 'Hello',
  text: 'How are you',
  imageUrl: 'https://placehold.it/300',
);

await ApplicationBadge.setReplyInputPlaceholderText("What's up?");

ApplicationBadge.send(notification);

ApplicationBadge.responses.listen((d) {
  print('Notification response: ${d.responseText}');
})

ApplicationBadge.onClick.listen((d) {
  print('Notification ${d} was clicked');
})
```
