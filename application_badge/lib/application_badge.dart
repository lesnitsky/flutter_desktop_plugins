import 'dart:async';

import 'package:flutter/services.dart';

const _methodChannel = const MethodChannel(
    'plugins.lesnitsky.com/application_badge_method_channel');

class ApplicationBadge {
  static setBadge(String badgeLabel) async {
    try {
      await _methodChannel.invokeMethod(
        'setBadge',
        badgeLabel,
      );
    } catch (err) {
      rethrow;
    }
  }

  static Future<void> clear() async {
    try {
      await _methodChannel.invokeMethod('clear');
    } catch (err) {
      rethrow;
    }
  }
}
