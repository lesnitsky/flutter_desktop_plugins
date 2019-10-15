# LocalNotifications plugin for desktop

⚠️ Flutter desktop plugins API is not yet finalized and may change, so this plugin may not be working at some point. File an issue if it doesn't.

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
  title: 'Hello',
  subtitle: 'How are you',
  text: 'My first notification',
  imageUrl: 'https://placehold.it/300',
);

LocalNotifications.send(notification);
```
