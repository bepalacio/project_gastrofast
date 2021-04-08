import 'package:f_202110_firebase_google_login/Formularios/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.orangeAccent,
      ),
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
            TextButton(
                child: Text("Cerrar sesión"),
                onPressed: () {
                  Navigator.of(context).pushReplacement(CupertinoPageRoute(
                    builder: (context) => (LoginPage()),
                  ));
                  _logout();
                })
          ],
        ),
      ),
    );
  }

  _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
