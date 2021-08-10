import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_notifications/ui/home.dart';
import 'package:firebase_notifications/utils/authentication.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: Authentication.initializeFirebase(context: context),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error initializing Firebase');
            } else if (snapshot.connectionState == ConnectionState.done) {
              return signInButton(context);
            }
            return CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.black,
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget signInButton(BuildContext context) {
  return ElevatedButton(
    onPressed: () async {
      User? user = await Authentication.signInWithGoogle(context: context);

      if (user != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomeView(),
          ),
        );
      }
    },
    child: Text('Login'),
  );
}
