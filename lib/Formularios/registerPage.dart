import 'package:f_202110_firebase_google_login/Formularios/googlePage.dart';
import 'package:f_202110_firebase_google_login/Formularios/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class RegisterPage extends StatefulWidget {
  final String titulo = 'Registrarse';

  State<StatefulWidget> createState() => _RegisterPageState();
}

final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titulo),
        actions: <Widget>[
          Builder(
            builder: (BuildContext context) {
              return FlatButton(
                child: const Text('Sign out'),
                onPressed: () async {
                  final User user = _auth.currentUser;
                  if (user == null) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: const Text('No one has signed in.'),
                    ));
                    return;
                  }
                  _signOut();
                  final String uid = user.uid;
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(uid + 'has succesfully signed out.'),
                  ));
                  //_signup(context, correo, pass);
                },
              );
            },
          )
        ],
      ),
      body: Builder(
        builder: (BuildContext context) {
          return ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              _GoogleSignInSection(),
            ],
          );
        },
      ),
    );
  }

  void _signOut() async {
    await _auth.signOut();
  }
}

class _GoogleSignInSection extends StatefulWidget {
  State<StatefulWidget> createState() => __GoogleSignInSectionState();
}

class __GoogleSignInSectionState extends State<_GoogleSignInSection> {
  bool _success;
  String _userId;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: const Text('Test sign in with Google'),
          padding: const EdgeInsets.all(15),
          alignment: Alignment.center,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              SignInButton(
                Buttons.Google,
                text: "Sign in with Google",
                onPressed: () {
                  _signInWithGoogle(context);
                },
              )
            ],
          ),
        )
      ],
    );
  }

  void _signInWithGoogle(BuildContext context) async {
    try {
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
      final UserCredential user = await _auth.signInWithCredential(credential);
      assert(user.user.displayName != null);
      assert(await user.user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.user.uid == currentUser.uid);
      setState(() {
        if (user.user != null) {
          _success = true;
          _userId = user.user.uid;
          Navigator.of(context).pushReplacement(CupertinoPageRoute(
            builder: (context) => Home(),
          ));
        }
      });
    } catch (err) {
      print(err);
      return null;
    }
  }
}
