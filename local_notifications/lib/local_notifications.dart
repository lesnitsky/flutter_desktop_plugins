import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:local_notifications/src/notification_response.dart';
import 'src/notification.dart';

export 'src/notification.dart';

const _methodChannel = const MethodChannel(
    'plugins.lesnitsky.com/local_notifications_method_channel');

const _eventChannel = const EventChannel(
    'plugins.lesnitsky.com/local_notifications_event_channel');

class LocalNotifications {
  static Stream get _stream =>
      _eventChannel.receiveBroadcastStream().map((d) => json.decode(d));

  /// [Stream] of responses received from displayed notification.
  /// Set [Notificaiton.requestReply] to true to show "Reply" button.
  static Stream<NotificationResponse> get responses =>
      _stream.where((d) => d['responseText'] != null).map((d) =>
          NotificationResponse(id: d['id'], responseText: d['responseText']));

  /// [Stream] of notification ids which where clicked.
  static Stream<String> get onClick =>
      _stream.where((d) => d['responseText'] == null).map((d) => d['id']);

  /// Sends notification
  static send(Notification notification) async {
    try {
      final args = notification.toMap();

      await _methodChannel.invokeMethod(
        'sendNotification',
        args,
      );
    } catch (err) {
      rethrow;
    }
  }

  /// Overrides reply input placeholder text. Await returned future before sending the notification
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
