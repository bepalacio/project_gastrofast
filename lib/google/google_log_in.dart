import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLogIn extends StatelessWidget {
  const GoogleLogIn({Key key}) : super(key: key);

  Future _signInWithGoogle() async {
    // get GoogleUser
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // authenticate against google with that user
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // get the credentials from the authentication to use on firebase
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // use those credentials to signin with firebase
    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SignInButton(
            Buttons.Google,
            text: "Sign in with Google",
            onPressed: () {
              _signInWithGoogle();
            },
          ),
        )
      ],
    );
  }
}
