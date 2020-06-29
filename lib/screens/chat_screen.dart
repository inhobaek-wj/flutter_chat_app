import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../widgets/chat/messages.dart';
import '../widgets/chat/new_message.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();

    final fbm = FirebaseMessaging();
    // this code below is for iOS, I actually did not set up for iOS push notification.
    fbm.requestNotificationPermissions();
    fbm.configure(
      onMessage: (msg) {
        return;
      },
      onLaunch: (msg) {
        return;
      },
      onResume: (msg) {
        return;
      },
    );

    fbm.subscribeToTopic('chat');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chat'),
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),

            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 8,),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'logout',
              )
            ],
            onChanged: (itemIndentifier) {
              if (itemIndentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),

      body: Container(
        child: Column(
          children: [
            Expanded( // ListView will not work well inside of column with Expanded.
              child: Messages(),
            ),

            NewMessage(),
          ],
        ),
      ),

    );
  }
}
