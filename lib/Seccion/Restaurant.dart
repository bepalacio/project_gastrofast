import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_202110_firebase_google_login/Seccion/RestaurantDetails.dart';
import 'package:f_202110_firebase_google_login/Seccion/RestaurantMenu.dart';
import 'package:f_202110_firebase_google_login/Seccion/RestaurantMaps.dart';
import 'package:f_202110_firebase_google_login/Seccion/SearchRestaurant.dart';
import 'package:flutter/material.dart';

class RestaurantEncounter extends StatefulWidget {
  RestaurantEncounter({Key key}) : super(key: key);

  @override
  _RestaurantEncounterState createState() => _RestaurantEncounterState();
}

class _RestaurantEncounterState extends State<RestaurantEncounter> {
  @override
  void initState() {
    super.initState();
    _buscarRestaurante();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurantes'),
        backgroundColor: Color.fromRGBO(245, 100, 90, 50),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: <Widget>[
                Text("Restaurantes encontrados",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
                SizedBox(
                  height: 15.0,
                ),
                SizedBox(
                  width: 300.0,
                  height: 150.0,
                  child: const Card(),
                ),
                SizedBox(
                  height: 15.0,
                ),
                SizedBox(
                    width: 300.0,
                    height: 150.0,
                    child: FlatButton(
                        child: Text(''),
                        color: Color.fromRGBO(136, 255, 0, 100),
                        onPressed: () => _pushPage(context, RestaurantMenu()))),
                SizedBox(
                  height: 15.0,
                ),
                SizedBox(
                  width: 300.0,
                  height: 150.0,
                  child: const Card(),
                ),
                SizedBox(
                  height: 15.0,
                ),
                ElevatedButton.icon(
                  label: Text('Ver en Mapa'),
                  icon: Icon(Icons.search),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(245, 100, 90, 50), // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () => _pushPage(context, RestaurantMaps()),
                )
              ],
            ),
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

void _buscarRestaurante() {
  String cat = categoria;
  print(cat);
  List rMenu = _obtenerDatos();
}

final firestoreInstance = FirebaseFirestore.instance;
List _obtenerDatos() {
  List datosR = [];
  firestoreInstance.collection("Restaurante_Menu").get().then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      print(result.data());
      datosR.add(result.data().values);
      //print("DatosR");
      print(datosR);
    });
  });
  return datosR;
}
