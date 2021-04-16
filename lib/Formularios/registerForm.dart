import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class RegisterForm extends StatefulWidget {
  final String titulo = "Registrarse";

  State<StatefulWidget> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  bool success;
  String userEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titulo),
        backgroundColor: Colors.orangeAccent,
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(244, 202, 110, 10),
      body: Form(
        key: _formKey,
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
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                  labelText: "Nombre de usuario",
                  icon: Icon(Icons.supervised_user_circle)),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Por favor ingrese un nombre de usuario';
                }
              },
            ),
            TextFormField(
              controller: _passController,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: "Contraseña", icon: Icon(Icons.vpn_key)),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Por favor ingrese una contraseña';
                }
              },
            ),
            TextFormField(
              controller: _confirmPassController,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: "Confirmar contraseña", icon: Icon(Icons.vpn_key)),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Por favor validar contraseña';
                }
              },
            ),
            TextFormField(
              controller: _nombreController,
              decoration: InputDecoration(
                  labelText: "Nombre completo",
                  icon: Icon(Icons.supervised_user_circle_outlined)),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Por favor ingrese su nombre completo';
                }
              },
            ),
            TextFormField(
              controller: _telefonoController,
              decoration: InputDecoration(
                  labelText: "Telefono",
                  icon: Icon(Icons.supervised_user_circle_outlined)),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Por favor ingrese su telefono';
                }
              },
            ),
            TextFormField(
              controller: _emailController,
              decoration:
                  InputDecoration(labelText: "Correo", icon: Icon(Icons.email)),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Por favor ingrese un correo';
                }
              },
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              alignment: Alignment.center,
              child: FlatButton(
                  child: Text('Registrarse'),
                  color: Color.fromRGBO(245, 100, 90, 100),
                  textColor: Colors.white,
                  minWidth: 250,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  onPressed: () {
                    _signup(
                        context, _emailController.text, _passController.text);
                    //dispose();
                  }),
            ),
            // Container(
            //   alignment: Alignment.center,
            //   child: Text(success == null
            //       ? ''
            //       : (success
            //           ? userEmail + ' se ha rgistrado con exito'
            //           : 'No se podido registrar el usuario')),
            // ),
          ],
        ),
      ),
    );
  }

  void dispose() {
    _nombreController.dispose();
    _confirmPassController.dispose();
    _usernameController.dispose();
    _passController.dispose();
    _emailController.dispose();
    _telefonoController.dispose();
    super.dispose();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void _register() async {
    final UserCredential user = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text, password: _passController.text);

    if (user.user != null) {
      setState(() {
        success = true;
        userEmail = user.user.email;
        addUser(
            user.user.uid,
            _nombreController.text,
            _usernameController.text,
            int.parse(_telefonoController.text),
            _emailController.text,
            _passController.text);
      });
    } else {
      success = false;
    }
  }

  Future<void> _signup(BuildContext context, correo, pass) async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: correo, password: pass);
      Navigator.of(context).pop();
      _showMyDialog(context, "El usuario se ha registrado correctamente.",
          "Registro exitoso");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        _showMyDialog(
            context,
            "La contraseña proporcionada es demasiado débil.",
            "Error de registro");
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        _showMyDialog(
            context,
            "Ya existe una cuenta con ese correo electrónico.",
            "Error de registro");
      }
    }
  }

  Future<void> addUser(String uid, String fullName, String username,
      int telefono, String correo, String pass) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'uid': uid,
          'name': fullName,
          'username': username,
          'phone': telefono,
          'email': correo,
          'password': pass
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> _showMyDialog(BuildContext context, mensaje, titulo) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titulo),
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
}

class AddUser extends StatelessWidget {
  final String fullName;
  final String username;
  final String pass;
  final String correo;
  final int telefono;

  AddUser(this.fullName, this.username, this.pass, this.correo, this.telefono);

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
            'name': fullName,
            'username': username,
            'phone': telefono,
            'email': correo,
            'password': pass
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return TextButton(
      onPressed: addUser,
      child: Text(
        "Add User",
      ),
    );
  }
}
