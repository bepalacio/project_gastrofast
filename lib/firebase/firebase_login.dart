import 'package:f_202110_firebase_google_login/firebase/firebase_signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class FirebaseLogIn extends StatelessWidget {
  const FirebaseLogIn({Key key}) : super(key: key);

  _login(correo, pass) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: correo, password: pass);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("user-not-found");
      } else if (e.code == 'wrong-password') {
        print("wrong-password");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: SignInButtonBuilder(
              backgroundColor: Colors.blueGrey[700],
              text: 'Sign in with Email',
              icon: Icons.email,
              onPressed: () {
                //_login();
              }),
        ),
        TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FirebaseSignUp()));
            },
            child: Text("Create account"))
      ],
    );
  }
}
