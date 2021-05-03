import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseLoggedIn extends StatelessWidget {
  const FirebaseLoggedIn({Key key}) : super(key: key);

  _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: TextButton(
              onPressed: () {
                _logout();
              },
              child: Text("Log out"))),
    );
  }
}
