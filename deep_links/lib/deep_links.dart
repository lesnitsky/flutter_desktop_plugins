import 'package:flutter/services.dart';

const _eventChannel = EventChannel('plugins.lesnitsky.com/deep_links');

class DeepLinks {
  Stream<String>? _onLinkReceived;

  static DeepLinks? _instance;
  static DeepLinks get instnace => _instance ??= DeepLinks();

  Stream<String> get onLinkReceived {
    if (_onLinkReceived != null) return _onLinkReceived!;
    _onLinkReceived = _eventChannel
        .receiveBroadcastStream()
        .map((dynamic event) => event as String);

    return _onLinkReceived!;
  }
}
