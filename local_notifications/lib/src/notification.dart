import 'package:flutter/foundation.dart';

class Notification {
  final String id;
  final String title;
  final String subtitle;
  final String text;
  final String imageUrl;
  final bool requestReply;

  const Notification({
    @required this.id,
    @required this.title,
    this.subtitle,
    @required this.text,
    this.imageUrl,
    this.requestReply = false,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {};

    map['id'] = id;
    map['title'] = title;
    map['text'] = text;
    map['requestReply'] = requestReply;

    if (subtitle != null) {
      map['subtitle'] = subtitle;
    }

    if (imageUrl != null) {
      map['imageUrl'] = imageUrl;
    }

    return map;
  }
}
