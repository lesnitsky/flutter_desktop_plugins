import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:local_notifications/local_notifications.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final random = new Random();

  final TextEditingController replyInputPlaceholderController =
      new TextEditingController();
  final TextEditingController textController = new TextEditingController();
  final TextEditingController titleController = new TextEditingController();
  final TextEditingController imageUrlController = new TextEditingController();
  final TextEditingController subtitleController = new TextEditingController();

  bool requestReply = false;

  @override
  void initState() {
    LocalNotifications.onClick.listen((d) {
      print('Notification $d clicked');
    });

    LocalNotifications.responses.listen((d) {
      print('Notification ${d.id} response: ${d.responseText}');
    });

    super.initState();
  }

  _sendNotification() async {
    await Future.delayed(Duration(milliseconds: 500));

    await LocalNotifications.setReplyInputPlaceholderText(
        replyInputPlaceholderController.text);

    final notification = new Notification(
      id: random.nextInt(1000).toString(),
      title: titleController.text,
      subtitle: subtitleController.text,
      text: textController.text,
      imageUrl:
          imageUrlController.text.length > 0 ? imageUrlController.text : null,
      requestReply: requestReply,
    );

    LocalNotifications.send(notification);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: subtitleController,
                decoration: InputDecoration(labelText: 'Subtitle'),
              ),
              TextField(
                controller: textController,
                decoration: InputDecoration(labelText: 'Text'),
              ),
              TextField(
                controller: imageUrlController,
                decoration: InputDecoration(labelText: 'Image URL'),
              ),
              ListTile(
                onTap: () {
                  setState(() {
                    requestReply = !requestReply;
                  });
                },
                leading: Checkbox(
                  value: requestReply,
                  onChanged: (v) {
                    setState(() {
                      requestReply = v;
                    });
                  },
                ),
                title: Text('Request reply'),
              ),
              RaisedButton(
                child: Text('Send'),
                onPressed: _sendNotification,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
