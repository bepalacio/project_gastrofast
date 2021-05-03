import 'package:f_202110_firebase_google_login/Formularios/loginPage.dart';
import 'package:f_202110_firebase_google_login/Formularios/menuLateral.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoggedIn extends StatelessWidget {
  final googleSignIn = GoogleSignIn();

  void _signOutGoogle() async {
    // sign out from google
    await googleSignIn.disconnect();
    // sign out from Firebase
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    // user from firebase
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Color.fromRGBO(245, 100, 90, 10),
      ),
      drawer: MenuLateral(),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              "Bienvenidos al sistema",
              style: TextStyle(color: Colors.orangeAccent, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            Text(
              "Id de Usuario: " + user.uid,
              style: TextStyle(color: Colors.orangeAccent, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            Text(
              "Correo: " + user.email,
              style: TextStyle(color: Colors.orangeAccent, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            // TextButton(
            //     child: Text("Cerrar sesión"),
            //     onPressed: () {
            //       Navigator.of(context).pushReplacement(CupertinoPageRoute(
            //         builder: (context) => (LoginPage()),
            //       ));
            //       _signOutGoogle();
            //     })
          ],
        ),
      ),
    );
    // return Column(
    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //   children: [
    //     CircleAvatar(
    //       maxRadius: 25,
    //       backgroundImage: NetworkImage(user.photoURL),
    //     ),
    //     Center(
    //         child: Text(
    //       'Name: ${user.displayName}',
    //     )),
    //     Text(
    //       'Email: ' + user.email,
    //     ),
    //     Center(
    //         child: TextButton(
    //       child: Text("Log out"),
    //       onPressed: () => {_signOutGoogle()},
    //     ))
    //   ],
    // );
  }
}
