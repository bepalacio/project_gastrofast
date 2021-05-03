import 'package:f_202110_firebase_google_login/Formularios/loginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  // this is the key
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginPage()
        // Scaffold(
        //     body: FutureBuilder(
        //   future: _initialization,
        //   builder: (context, snapshot) {
        //     if (snapshot.hasError) {
        //       print("error ${snapshot.error}");
        //       return Wrong();
        //     }
        //     if (snapshot.connectionState == ConnectionState.done) {
        //       //return GoogleCentral();
        //       return FirebaseCentral();
        //     }

        //     return Loading();
        //   },
        // )),
        );
  }
}

class Wrong extends StatelessWidget {
  const Wrong({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Something went wrong")),
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Loading")),
    );
  }
}
