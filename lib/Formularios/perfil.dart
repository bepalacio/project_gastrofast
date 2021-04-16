import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Perfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return MaterialApp(
      title: 'Perfil de usuario',
      // routes: <String, WidgetBuilder>{
      //   '/LoginPage': (BuildContext context) => new LoginPage(),
      //   '/GoogleLogin': (BuildContext context) => new GoogleLogIn(),
      //   '/Home': (BuildContext context) => new Home()
      // },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Perfil_Usuario(title: 'interface'),
    );
  }
}

class Perfil_Usuario extends StatelessWidget {
  const Perfil_Usuario({Key key, String title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
      width: 414,
      height: 896,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xfff4ca6d),
      ),
      child: Column(
        children: [],
      ),
    );
  }
}
