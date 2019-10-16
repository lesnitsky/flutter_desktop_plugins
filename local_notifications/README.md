# LocalNotifications plugin for desktop

⚠️ Flutter desktop plugins API is not yet finalized and may change, so this plugin may not be working at some point. File an issue if it doesn't.

![Screenshot](https://screenshots-lesnitsky.s3.eu-west-2.amazonaws.com/flutter_local_notifications.jpg)

## Installation

`pubspec.yaml`

```pubspec.yaml
...
dependencies:
  local_notifications:
    git:
      url: git://github.com/lesnitsky/flutter_desktop_plugins.git
      path: local_notifications
...
```

## Usage

```dart
import 'package:local_notifications/local_notifications.dart';

final notification = new Notification(
  id: 'unique-id',
  title: 'Notification sent from flutter',
  subtitle: 'Hello',
  text: 'How are you',
  imageUrl: 'https://placehold.it/300',
);

await LocalNotifications.setReplyInputPlaceholderText("What's up?");

LocalNotifications.send(notification);

LocalNotifications.responses.listen((d) {
  print('Notification response: ${d.responseText}');
})

LocalNotifications.onClick.listen((d) {
  print('Notification ${d} was clicked');
})
```
