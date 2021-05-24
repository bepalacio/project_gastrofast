import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_202110_firebase_google_login/Formularios/RegisterForm.dart';
import 'package:f_202110_firebase_google_login/Seccion/SearchRestaurant.dart';
import 'package:f_202110_firebase_google_login/Seccion/CartProduct.dart';
import 'package:f_202110_firebase_google_login/Seccion/RestaurantDetails.dart';
import 'package:f_202110_firebase_google_login/Seccion/PaymentMethod.dart';
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

bool sw1 = false;
bool sw2 = false;

class LoginPage extends StatefulWidget {
  final String titulo;

  LoginPage({Key key, this.titulo}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

String emaill = "";
String passs = "";

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

  void initState() {
    _emailController = TextEditingController();
    _passController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.only(left: 0, right: 0, top: 0),
        color: Color.fromRGBO(244, 202, 110, 100),
        child: Column(
          children: <Widget>[
            Container(
              height: 150,
              width: 400,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(245, 100, 90, 1),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  )),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  SizedBox(height: 20),
                  Text("GASTROFAST",
                      style: TextStyle(
                          color: Color.fromRGBO(136, 255, 0, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 30)),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 30,
                      ),
                      FlatButton(
                        child: Text('Login'),
                        color: Colors.transparent,
                        textColor: Colors.black,
                        onPressed: () => _pushPage(context, LoginPage()),
                      ),
                      Spacer(),
                      FlatButton(
                        child: Text('Registrarse'),
                        color: Colors.transparent,
                        textColor: Colors.black,
                        onPressed: () => _pushPage(context, RegisterForm()),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 40, right: 40, top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        "Correo Electronico",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Color.fromRGBO(0, 0, 0, 100)),
                      ),
                    ],
                  ),
                  TextField(
                    controller: _emailController,
                    /*
                    decoration: InputDecoration(
                        suffix: GestureDetector(
                      child: Icon(Icons.access_alarm_outlined),
                      onTap: () {
                        _emailController.clear();
                      },
                    )),
                    */
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    children: [
                      Text(
                        "Contraseña",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Color.fromRGBO(0, 0, 0, 100)),
                      ),
                    ],
                  ),
                  TextField(
                    obscureText: true,
                    controller: _passController,
                  ),
                ],
              ),
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
              color: Color.fromRGBO(245, 100, 90, 50),
              textColor: Colors.white,
              minWidth: 250,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              onPressed: () {
                _login(context, _emailController.text, _passController.text);
              },
            ),
            Container(
              padding: EdgeInsets.only(left: 40, right: 40, top: 20),
              child: Row(
                children: [
                  IconButton(
                    icon: Image.asset("assets/images/facebook.png"),
                    iconSize: 50,
                    onPressed: () {},
                  ),
                  Spacer(),
                  IconButton(
                    icon: Image.asset("assets/images/google.png"),
                    iconSize: 50,
                    onPressed: () {
                      _signInWithGoogle(context);
                    },
                  ),
                  Spacer(),
                  IconButton(
                    icon: Image.asset("assets/images/Twitter.png"),
                    iconSize: 50,
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final firestoreInstance = FirebaseFirestore.instance;

Future<void> addUser(String uid, String fullName, String username, int telefono,
    String correo, String pass, BuildContext context, String foto) {
  print("Agregando usuario");
  print("NOmbre: " + fullName);
  print("username: " + username);
  print("telefono: " + telefono.toString());
  print("correo: " + correo);
  print("pass: " + pass);
  // Call the user's CollectionReference to add a new user
  var firebaseUser = FirebaseAuth.instance.currentUser;
  firestoreInstance
      .collection("users")
      .doc(firebaseUser.uid)
      .set({
        'name': fullName,
        'username': username,
        'phone': telefono,
        'email': correo,
        'password': pass,
        'photo': foto
      })
      .then((_) => print("User Added" + firebaseUser.uid))
      .catchError((error) => print("Failed to add user: $error"));
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
    addUser(currentUser.user.uid, currentUser.user.displayName, "username", 0,
        currentUser.user.email, "", context, currentUser.user.photoURL);
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
