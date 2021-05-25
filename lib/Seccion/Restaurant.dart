import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_202110_firebase_google_login/Seccion/RestaurantDetails.dart';
import 'package:f_202110_firebase_google_login/Seccion/RestaurantMenu.dart';
import 'package:f_202110_firebase_google_login/Seccion/RestaurantMaps.dart';
import 'package:f_202110_firebase_google_login/Seccion/SearchRestaurant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
    rest_id = 0;
    rest_id = 0;
    _buscarRestaurante();
  }

  void _initializeTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
    // acción de configuración después de 5 minutos
    _timer = Timer(const Duration(seconds: 2), () => _handleInactivity());
  }

  void _initializeTimer1() {
    if (_timer != null) {
      _timer.cancel();
    }
    // acción de configuración después de 5 minutos
    _timer = Timer(const Duration(seconds: 1), () => _handleInactivity1());
  }

  void _initializeTimer2() {
    if (_timer != null) {
      _timer.cancel();
    }
    // acción de configuración después de 5 minutos
    _timer = Timer(const Duration(seconds: 1), () => _handleInactivity2());
  }

  void _handleInactivity() {
    _timer?.cancel();
    _timer = null;
    _obtenerDatosRest();

    _initializeTimer1();
    // _pushPage(context, RestaurantDetails());
    // print("Nombre restaurante: " + nombreD);
  }

  void _handleInactivity1() {
    _timer?.cancel();
    _timer = null;
    _obtenerDatosFavoritos();
    _initializeTimer2();
  }

  void _handleInactivity2() {
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
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                                padding: EdgeInsets.all(7),
                                width: 300.0,
                                height: 100.0,
                                color: Colors.white,
                                child: Row(children: [
                                  /*Icono del restaurante*/
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      /*
                                        image: const DecorationImage(
                                          image: AssetImage(
                                              "assets/Comida/pizza.png"),
                                          fit: BoxFit.cover,
                                        ),
                                        */
                                      border: Border.all(
                                        color: Color.fromRGBO(229, 147, 40, 1),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  /*Separador*/
                                  SizedBox(width: 20),
                                  /*Informacion del restaurante*/
                                  /*Click para encontrar info del reaturante*/
                                  GestureDetector(
                                    onTap: () {
                                      _pushPage(context, RestaurantMenu());

                                      control = text.toString();
                                    },
                                    child: new Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: RichText(
                                        text: new TextSpan(
                                          // Note: Styles for TextSpans must be explicitly defined.
                                          // Child text spans will inherit styles from parent
                                          style: new TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black,
                                          ),
                                          children: <TextSpan>[
                                            new TextSpan(
                                                text: '' + "\n\n",
                                                style: new TextStyle(
                                                    color: Colors.orange,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            new TextSpan(
                                                text: text.toString() + "\n\n",
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            new TextSpan(
                                                text: '' + "",
                                                style: new TextStyle(
                                                    color: Colors.orange,
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                      color: Colors.white,
                                      child: new Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            Row(
                                              children: [
                                                Container(
                                                  child: IconButton(
                                                      icon: const Icon(
                                                        Icons.navigate_next,
                                                        color: Colors.black,
                                                      ),
                                                      color: Colors.white,
                                                      onPressed: () {
                                                        setState(() {
                                                          control =
                                                              text.toString();
                                                          _obtenerDetalleRestaurante(
                                                              control);
                                                          print(
                                                              "detalle Nombre:" +
                                                                  nombreD);
                                                          _initializeTimer();
                                                          print("control: " +
                                                              control);
                                                        });
                                                      }),
                                                ),
                                              ],
                                            ),
                                          ])),
                                ])),
                          ],
                        ),
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
                    onPressed: () {
                      _launchURL("https://goo.gl/maps/2QHdzVvD8pVisxxh7");
                    },
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
  print("rMenu");
  print(rMenu);
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
      String catego = result.get("Categoria");
      String desc = result.get("Descripcion");
      int id = result.get("ID_Restaurant");
      String imagen = result.get("Imagen");
      String nombre = result.get("Nombre");
      int precio = result.get("Precio");
      List data = [];
      data.add(nombre);
      data.add(catego);
      data.add(id);
      data.add(desc);
      data.add(imagen);
      data.add(precio);
      // print(data);
      datosR.add(data);
      // print(datosR);
    });
  });
  datosR1 = datosR.toList();
  print(datosR1);
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

void _obtenerDatosRest() async {
  print("Nombre: ..." + nombreD);
  await firestoreInstance
      .collection("Restaurantes")
      .where("Nombre", isEqualTo: nombreD)
      .get()
      .then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      id_rest = result.get("ID");
      print(id_rest);
    });
  });
}

bool fav = false;
void _obtenerDatosFavoritos() async {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  print("UID: " + firebaseUser.uid);
  await firestoreInstance
      .collection("Favoritos")
      .where("ID_usuario", isEqualTo: firebaseUser.uid.toString())
      .where("ID_restaurante", isEqualTo: id_rest)
      .get()
      .then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      rest_id = result.get("ID_restaurante");
      print("rest: " + rest_id.toString());
    });
  });
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
