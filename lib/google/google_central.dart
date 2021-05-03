import 'package:f_202110_firebase_google_login/google/google_log_in.dart';
import 'package:f_202110_firebase_google_login/google/google_logged_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GoogleCentral extends StatelessWidget {
  const GoogleCentral({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GoogleLoggedIn();
          } else {
            return GoogleLogIn();
          }
        },
      ),
    );
  }
}
