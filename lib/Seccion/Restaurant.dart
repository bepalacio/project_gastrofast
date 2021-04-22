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
    //datosR.clear();
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
        child: ListView(children: <Widget>[
          Padding(
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
                  Column(
                      children: restauranteDetalle.map((text) {
                    return SizedBox(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10.0,
                          ),
                          SizedBox(
                              width: 300.0,
                              height: 150.0,
                              child: FlatButton(
                                  child: Text(
                                    text.toString(),
                                    style: TextStyle(
                                        fontSize: 25.0,
                                        color:
                                            Color.fromRGBO(245, 100, 90, 50)),
                                  ),
                                  color: Colors.white,
                                  onPressed: () {
                                    _pushPage(context, RestaurantMenu());

                                    control = text.toString();
                                  })),
                        ],
                      ),
                    );
                  }).toList()),
                  SizedBox(
                    height: 10.0,
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
        ]),
      ),
    );
  }
}

void _pushPage(BuildContext context, Widget page) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(builder: (_) => page),
  );
}

List rMenu = [];
List rest = [];
List restauranteDetalle = [];
List restauranteId = [];
String control = "";

List _buscarRestaurante() {
  String cat = categoria;
  print(cat);

  rMenu = _obtenerDatosMenu("Restaurante_Menu").toList();
  //datosR.clear();
  rest = _obtenerDatosRestaurante("Restaurantes").toList();
  List categorias = [];
  List ids = [];
  List idR = [];
  List restaurantes = [];
  for (final x in rest) {
    print(x);
    List r = x.toString().split(",");
    String id = r[3].toString().substring(1, 2);

    print(id);
    idR.add(id);
  }

  for (final x in rMenu) {
    // print(x);
    List menu = x.toString().split(",");
    // print(menu[1]);
    categorias.add(menu[1]);
    ids.add(menu[2]);
  }

  for (var i = 0; i < idR.length; i++) {
    for (var j = 0; j < ids.length; j++) {
      String c0 = categorias[j].toString().split(" ").join("");
      int id1 = int.parse(ids[j]);
      int id2 = int.parse(idR[i]);
      // print(c0 + " = " + cat);
      // print(id1.toString() + " = " + id2.toString());
      if (id1 == id2) {
        if (c0 == cat.toString()) {
          print(id1);
          print(c0);
          restaurantes.add(id1);
          print("........");
        }
      }
    }
  }
  restaurantes = restaurantes.toSet().toList();
  print(restaurantes);
  List restaurante = [];
  List restauranteIds = [];
  for (final x in rest) {
    print(x);
    List r = x.toString().split(",");
    int id = int.parse(r[3].toString().substring(1, 2));
    for (var y = 0; y < restaurantes.length; y++) {
      int idRest = int.parse(restaurantes[y].toString());
      if (id == idRest) {
        restaurante.add(r[0].toString().substring(1));
        restauranteIds.add(id);
      }
    }
  }
  restauranteDetalle = restaurante;
  restauranteId = restauranteIds;
  print(restauranteDetalle);
  return restaurante;
}

List datosR = [];
List datosMenu = [];
List datosR1 = [];
List datosM1 = [];

final firestoreInstance = FirebaseFirestore.instance;
List _obtenerDatosMenu(String tabla) {
  firestoreInstance.collection(tabla).get().then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      //print(result.data());
      datosR.add(result.data().values);
    });
  });
  datosR1 = datosR.toList();
  datosR.clear();
  return datosR1;
}

List _obtenerDatosRestaurante(String tabla) {
  firestoreInstance.collection(tabla).get().then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      //print(result.data());
      datosMenu.add(result.data().values);
    });
  });
  datosM1 = datosMenu.toList();
  datosMenu.clear();
  return datosM1;
}
