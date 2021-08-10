import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_notifications/services/local_notification.dart';
import 'package:firebase_notifications/ui/login.dart';
import 'package:firebase_notifications/ui/screen_one.dart';
import 'package:firebase_notifications/ui/screen_two.dart';
import 'package:flutter/material.dart';

//OnMessage Background
Future<void> _messageHandler(RemoteMessage message) async {
  print('background message ${message.notification!.body}');
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Notifications Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        'screen_one': (_) => ScreenOne(),
        'screen_two': (_) => ScreenTwo()
      },
      home: LoginView(),
    );
  }
}
