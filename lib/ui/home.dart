import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_notifications/services/local_notification.dart';
import 'package:firebase_notifications/ui/login.dart';
import 'package:firebase_notifications/utils/authentication.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  _HomeViewState();

  @override
  void initState() {
    super.initState();
    LocalNotificationService.initialize(context);
    //terminated app Ontap
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        print('Message clicked! ' + message.data['route']);
        Navigator.pushNamed(context, message.data['route']);
      }
    });

    //Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      if (event.notification != null) {
        print("Message Recieved " + event.notification!.body!);
      }
      LocalNotificationService.display(event);
    });

    //Background but app in not terminated
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked! ' + message.data['route']);
      Navigator.pushNamed(context, message.data['route']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Authentication.signOut(context: context).then(
              (value) => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => LoginView(),
                ),
              ),
            );
          },
          child: Text('Signout'),
        ),
      ),
    );
  }
}
