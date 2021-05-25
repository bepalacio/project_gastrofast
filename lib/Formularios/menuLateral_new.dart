import 'package:f_202110_firebase_google_login/Formularios/home.dart';
import 'package:f_202110_firebase_google_login/Formularios/perfil.dart';
// import 'package:f_202110_firebase_google_login/Formularios/Politicas_de_Privacidad.dart';
import 'package:f_202110_firebase_google_login/Seccion/SearchRestaurant.dart';
import 'package:f_202110_firebase_google_login/dialog/policy_dialog.dart';
import 'package:f_202110_firebase_google_login/google/google_log_in.dart';
import 'package:f_202110_firebase_google_login/google/google_logged_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'loginPage.dart';
import 'loginPage.dart' as loginp;
import 'package:f_202110_firebase_google_login/google/google_log_in.dart'
    as loging;

class MenuLateral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return MaterialApp(
      title: 'Interfaces Test',
      routes: <String, WidgetBuilder>{
        '/LoginPage': (BuildContext context) => new LoginPage(),
        '/GoogleLogin': (BuildContext context) => new GoogleLogIn(),
        '/Home': (BuildContext context) => new Home(),
        '/Perfil': (BuildContext context) => new Perfil()
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Interface_Entrada(title: 'interface'),
    );
  }
}

final googleSignIn = GoogleSignIn();

class Interface_Entrada extends StatelessWidget {
  const Interface_Entrada({Key key, String title}) : super(key: key);

  void _signOutGoogle() async {
    // sign out from google
    await googleSignIn.disconnect();
    // sign out from Firebase
    FirebaseAuth.instance.signOut();
    loging.sw = false;
    print("Salir login google");
  }

  void _logout() async {
    try {
      FirebaseAuth.instance.signOut();
      loginp.sw1 = false;
      print("Salir login page" + loginp.sw1.toString());
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Padding(
      padding: new EdgeInsets.only(top: statusBarHeight),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromRGBO(245, 100, 90, 1),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 60),
              TextButton(
                  onPressed: () => _pushPage(context, Perfil()),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.account_circle_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(width: 7),
                      Text(
                        'Perfil',
                        //style: TextStyle(fontFamily: 'Roboto'),
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )),
              Divider(
                height: 5,
                color: Colors.white,
                indent: 35,
                endIndent: 120,
              ),
              SizedBox(height: 10),
              TextButton(
                  onPressed: () => _pushPage(context, SearchRestaurant()),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(width: 7),
                      Text(
                        'Realizar orden',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )),
              Divider(
                height: 5,
                color: Colors.white,
                indent: 35,
                endIndent: 120,
              ),
              SizedBox(height: 10),
              TextButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.local_offer_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(width: 7),
                      Text(
                        'Ofertas y promociones',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )),
              Divider(
                height: 5,
                color: Colors.white,
                indent: 35,
                endIndent: 120,
              ),
              SizedBox(height: 10),
              TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return PolicyDialog(
                            mdFileName: 'privacipolicy.md',
                          );
                        });
                  },
                  //_pushPage(context, PoliticasDePrivacidad()),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.privacy_tip_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(width: 7),
                      Text(
                        'Politicas de privacidad',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )),
              Divider(
                height: 5,
                color: Colors.white,
                indent: 35,
                endIndent: 120,
              ),
              SizedBox(height: 10),
              TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return PolicyDialog(
                            mdFileName: 'terminosycondiciones.md',
                          );
                        });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.security_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(width: 7),
                      Text(
                        'Terminos y condiciones',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )),
              Divider(
                height: 5,
                color: Colors.white,
                indent: 35,
                endIndent: 120,
              ),
              Spacer(),
              TextButton(
                  onPressed: () {
                    if (loginp.sw1 == true) {
                      Navigator.of(context).pushReplacement(CupertinoPageRoute(
                        builder: (context) => (LoginPage()),
                      ));
                      _logout();
                    } else {
                      if (loginp.sw2 == true) {
                        Navigator.of(context)
                            .pushReplacement(CupertinoPageRoute(
                          builder: (context) => (LoginPage()),
                        ));
                        _signOutGoogle();
                      }
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      SizedBox(width: 7),
                      Text(
                        'Cerrar Sesion',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

void _pushPage(BuildContext context, Widget page) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(builder: (_) => page),
  );
}
