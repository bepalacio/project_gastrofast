import 'package:f_202110_firebase_google_login/Formularios/RegisterForm.dart';
import 'package:f_202110_firebase_google_login/Formularios/home.dart';
import 'package:f_202110_firebase_google_login/Formularios/menuLateral.dart';
import 'package:f_202110_firebase_google_login/Formularios/registerPage.dart';
import 'package:f_202110_firebase_google_login/google/google_central.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'emailPage.dart';

bool sw1 = false;
bool sw2 = false;

class LoginPage extends StatefulWidget {
  final String titulo;

  LoginPage({Key key, this.titulo}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  _login(BuildContext context, correo, pass) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: correo, password: pass)
          .then((UserCredential currentUser) {
        Navigator.of(context).pushReplacement(CupertinoPageRoute(
          builder: (context) => MenuLateral(),
        ));
        sw1 = true;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("user-not-found");
        _showMyDialog(context, "Correo no registrado");
      } else if (e.code == 'wrong-password') {
        print("wrong-password");
        _showMyDialog(context, "Contraseña incorrecta");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.orangeAccent,
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(244, 202, 110, 100),
              Color.fromRGBO(244, 202, 110, 100),
            ],
          ),
        ),
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("GASTROFAST",
                style: TextStyle(
                    color: Color.fromRGBO(136, 255, 0, 100),
                    fontWeight: FontWeight.bold,
                    fontSize: 30)),
            SizedBox(
              height: 15.0,
            ),
            Row(
              children: [
                FlatButton(
                  child: Text('Login'),
                  color: Color.fromRGBO(245, 100, 90, 100),
                  textColor: Colors.white,
                  onPressed: () => null,
                ),
                Spacer(),
                FlatButton(
                  child: Text('Registrarse'),
                  color: Color.fromRGBO(245, 100, 90, 100),
                  textColor: Colors.white,
                  onPressed: () => _pushPage(context, RegisterForm()),
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  labelText: "Correo Electronico", icon: Icon(Icons.email)),
            ),
            SizedBox(
              height: 15.0,
            ),
            TextField(
              controller: _passController,
              decoration: InputDecoration(
                  labelText: "Contraseña", icon: Icon(Icons.vpn_key)),
              obscureText: true,
            ),
            SizedBox(
              height: 30.0,
            ),
            Text('¿Olvidaste tu contraseña?',
                style: TextStyle(color: Color.fromRGBO(250, 100, 0, 100))),
            SizedBox(
              height: 70.0,
            ),
            FlatButton(
              child: Text("Iniciar Seccion"),
              color: Color(0xFFF5645A),
              textColor: Colors.white,
              minWidth: 250,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(color: Colors.red)),
              onPressed: () {
                _login(context, _emailController.text, _passController.text);
              },
            ),
            SignInButton(Buttons.Google, text: "Google", onPressed: () {
              _signInWithGoogle(context);
            }),
            SignInButton(Buttons.Facebook,
                text: "Facebook",
                onPressed: () => _pushPage(context, GoogleCentral())),
            SignInButton(Buttons.Twitter,
                text: "Twitter",
                onPressed: () => _pushPage(context, GoogleCentral()))
          ],
        ),
      ),
    );
  }
}

Future _signInWithGoogle(BuildContext context) async {
  // get GoogleUser
  final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

  // authenticate against google with that user
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  // get the credentials from the authentication to use on firebase
  final GoogleAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // use those credentials to signin with firebase
  await FirebaseAuth.instance
      .signInWithCredential(credential)
      .then((UserCredential currentUser) {
    sw2 = true;
    Navigator.of(context).pushReplacement(CupertinoPageRoute(
      builder: (context) => MenuLateral(),
    ));
  });
}

Future<void> _showMyDialog(BuildContext context, mensaje) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error de acceso al sistema'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(mensaje),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Listo'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void _pushPage(BuildContext context, Widget page) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(builder: (_) => page),
  );
}
