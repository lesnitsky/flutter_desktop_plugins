import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const MethodChannel _channel =
    const MethodChannel('plugins.lesnitsky.com/deep_links');

class DeepLinks extends ValueNotifier<String> {
  static DeepLinks _instance;
  factory DeepLinks() => _instance ??= DeepLinks._();

  DeepLinks._() : super(null) {
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  _handleMethodCall(MethodCall call) {
    if (call.method == 'openLink') {
      this.value = call.arguments[0];
    }
  }
}
