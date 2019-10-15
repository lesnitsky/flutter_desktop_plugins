import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'src/notification.dart';

export 'src/notification.dart';

const _methodChannel = const MethodChannel(
    'plugins.lesnitsky.com/local_notifications_method_channel');

const _eventChannel = const EventChannel(
    'plugins.lesnitsky.com/local_notifications_event_channel');

class LocalNotifications {
  static bool _listening = false;
  static Stream _eventsStream;

  static send(Notification notification) async {
    try {
      final args = notification.toMap();

      await _methodChannel.invokeMethod(
        'sendNotification',
        args,
      );

      final responseCompleterCompleter = new Completer();
      StreamSubscription sub;

      if (notification.requestReply) {
        if (!_listening) {
          _eventsStream = _eventChannel.receiveBroadcastStream();
          _listening = true;
        }

        sub = _eventsStream.map((d) => json.decode(d)).listen((data) {
          if (data['id'] == notification.id) {
            responseCompleterCompleter.complete(data['response']);
            sub.cancel();
          }
        });
      } else {
        return null;
      }

      final responseCompleter = await responseCompleterCompleter.future;
      sub.cancel();
      return responseCompleter;
    } catch (err) {
      rethrow;
    }
  }

  static Future<void> setReplyInputPlaceholderText(String text) async {
    try {
      await _methodChannel.invokeMethod(
        'setReplyInputPlaceholderText',
        text,
      );
    } catch (err) {
      rethrow;
    }
  }
}
