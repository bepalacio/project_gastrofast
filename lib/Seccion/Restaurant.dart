import 'dart:async';

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

Timer _timer;

class _RestaurantEncounterState extends State<RestaurantEncounter> {
  @override
  void initState() {
    super.initState();
    //datosR.clear();
    _buscarRestaurante();
  }

  void _initializeTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
    // acción de configuración después de 5 minutos
    _timer = Timer(const Duration(seconds: 2), () => _handleInactivity());
  }

  void _handleInactivity() {
    _timer?.cancel();
    _timer = null;
    _pushPage(context, RestaurantDetails());
    print("Nombre restaurante: " + nombreD);
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
                          Container(
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
                          Container(
                              // width: 300.0,
                              // height: 30.0,
                              color: Colors.white,
                              child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    IconButton(
                                        icon: const Icon(
                                          Icons.navigate_next,
                                          color: Colors.black,
                                        ),
                                        color: Colors.white,
                                        onPressed: () {
                                          setState(() {
                                            control = text.toString();
                                            _obtenerDetalleRestaurante(control);

                                            print("detalle Nombre:" + nombreD);
                                            _initializeTimer();

                                            print("control: " + control);
                                          });
                                        }),
                                  ])),
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

void _pushPage(BuildContext context, Widget page) async {
  await Navigator.of(context).push(
    MaterialPageRoute<void>(builder: (_) => page),
  );
}

List rMenu = [];
List rest = [];
List restauranteDetalle = [];
List restauranteId = [];
String control = "";

List _buscarRestaurante() {
  List cat = categories;
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
    String id = r[3].toString().split(")").join("");

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
        for (final c in cat) {
          if (c0 == c.title.toString()) {
            print(id1);
            print(c0);
            restaurantes.add(id1);
            print("........");
          }
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
    int id = int.parse(r[3].toString().split(")").join(""));
    for (var y = 0; y < restaurantes.length; y++) {
      int idRest = int.parse(restaurantes[y].toString());
      print(idRest);
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

String nombreD;
String direccionD;
int tiempoD;
int ident;
String descripcionD;

void _obtenerDetalleRestaurante(String nombre) async {
  await firestoreInstance
      .collection("Restaurante_Details")
      .where("Nombre", isEqualTo: nombre)
      .get()
      .then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      print(result.data());
      nombreD = result.get("Nombre");
      direccionD = result.get("Direccion");
      tiempoD = result.get("Tiempo de llegada");
      descripcionD = result.get("Descripcion");
      ident = result.get("ID");
    });
    nombreD = nombreD;
    print("Nombre D:" + nombreD);
    print("ID:" + ident.toString());
  });
  _obtenerMenuRestaurante(ident);
  print("Nombre D1:" + nombreD);
}

String linkMenu;

void _obtenerMenuRestaurante(int id) async {
  await firestoreInstance
      .collection("Restaurante_DMenu")
      .where("ID", isEqualTo: id)
      .get()
      .then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      print(result.data());
      linkMenu = result.get("Link");
    });
    print("Link Menu: " + linkMenu);
  });
  print("Link Menu: " + linkMenu);
}
