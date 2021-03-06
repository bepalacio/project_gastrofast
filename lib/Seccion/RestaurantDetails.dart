import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_202110_firebase_google_login/Seccion/Restaurant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:url_launcher/url_launcher.dart';

import 'RestaurantMenu.dart';

/// This is the main application widget.

/// This is the stateful widget that the main application instantiates.
class RestaurantDetails extends StatefulWidget {
  const RestaurantDetails({Key key}) : super(key: key);

  @override
  _RestaurantDetailsState createState() => _RestaurantDetailsState();
}

Timer _timer;

/// This is the private State class that goes with MyStatefulWidget.
class _RestaurantDetailsState extends State<RestaurantDetails> {
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;

  @override
  void initState() {
    super.initState();
    _validarFavorito();
    _obtenerDatosFavoritos();
  }

  void _initializeTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
    // acción de configuración después de 5 minutos
    _timer = Timer(const Duration(seconds: 1), () => _handleInactivity());
  }

  void _initializeTimer1() {
    if (_timer != null) {
      _timer.cancel();
    }
    // acción de configuración después de 5 minutos
    _timer = Timer(const Duration(seconds: 1), () => _handleInactivity1());
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
    _obtenerDatosFavorito();
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: _pinned,
            snap: _snap,
            floating: _floating,
            backgroundColor: Color.fromRGBO(244, 202, 110, 100),
          ),
          const SliverToBoxAdapter(),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
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
                          Text("Detalles del restaurante",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15)),
                          SizedBox(
                            width: 300.0,
                            height: 15.0,
                          ),
                          Container(
                            width: 300,
                            height: 100,
                            child: Align(
                              alignment: Alignment(0.8, 0),
                              child: Text(" Nombre Restaurante:" +
                                  nombreD +
                                  " \n\n Direccion: " +
                                  direccionD +
                                  "\n\n Tiempo: " +
                                  tiempoD.toString() +
                                  " minutos \n"),
                            ),
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle, color: Colors.white),
                            padding: EdgeInsets.all(10.0),
                          ),
                          SizedBox(
                            width: 300.0,
                            height: 15.0,
                          ),
                          Container(
                            width: 300,
                            height: 20,
                            child: Align(
                              alignment: Alignment(-1, -1),
                              child: Text("Descripcion"),
                            ),
                          ),
                          Container(
                            width: 300,
                            child: Align(
                              alignment: Alignment(-1, -1),
                              child: Text(descripcionD),
                            ),
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle, color: Colors.white),
                            padding: EdgeInsets.all(10.0),
                          ),
                          SizedBox(
                            width: 300.0,
                            height: 15.0,
                          ),
                          MaterialButton(
                            minWidth: 300.0,
                            height: 40.0,
                            onPressed: () {},
                            color: Colors.blue[900],
                            child: Text('Facebook',
                                style: TextStyle(color: Colors.white)),
                          ),
                          MaterialButton(
                            minWidth: 300.0,
                            height: 40.0,
                            onPressed: () {},
                            color: Colors.red[400],
                            child: Text('Instagram',
                                style: TextStyle(color: Colors.white)),
                          ),
                          MaterialButton(
                            minWidth: 300.0,
                            height: 40.0,
                            onPressed: () {},
                            color: Colors.lightGreenAccent[700],
                            child: Text('Whatsapp',
                                style: TextStyle(color: Colors.white)),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FavoriteButton(
                                  isFavorite: fav,
                                  valueChanged: (_isFavorite) {
                                    if (_isFavorite == false) {
                                      _eliminarFavorito();
                                      _initializeTimer();
                                      id_rest = 0;
                                      rest_id = 0;
                                    } else {
                                      _agregarFavorito();
                                      _initializeTimer();
                                      _obtenerDatosFavoritos();
                                    }
                                    print('Is Favorite $_isFavorite');
                                  },
                                ),
                                Spacer(),
                                Container(
                                  child: TextButton.icon(
                                    onPressed: () {
                                      print(linkMenu);
                                      String url = linkMenu;
                                      _launchURL(url);
                                    },
                                    icon: Icon(
                                      Icons.cloud_download_outlined,
                                      size: 18,
                                      color: Colors.blueAccent,
                                    ),
                                    label: Text(
                                      "Descargar Menu",
                                      style:
                                          TextStyle(color: Colors.blueAccent),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}

final firestoreInstance = FirebaseFirestore.instance;

void _eliminarFavorito() {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  firestoreInstance.collection("Favoritos").doc(uidF).delete().then((_) {
    print("Eliminado!");
  });
}

void _agregarFavorito() {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  firestoreInstance.collection("Favoritos").add({
    "ID_restaurante": id_rest,
    "ID_usuario": firebaseUser.uid,
  }).then((value) {
    print("Agregado a favorito");
  });
}

String uidF;
void _obtenerDatosFavoritos() async {
  var firebaseUser = FirebaseAuth.instance.currentUser;

  await firestoreInstance
      .collection("Favoritos")
      .where("ID_restaurante", isEqualTo: id_rest)
      .where("ID_usuario", isEqualTo: firebaseUser.uid)
      .get()
      .then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      uidF = result.id;
    });
  });
}

void _validarFavorito() {
  print("id_rest: " + id_rest.toString());
  print("rest_id: " + rest_id.toString());
  if (id_rest == rest_id) {
    fav = true;
  } else {
    fav = false;
  }
  print(fav);
}

int id_rest;

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

int rest_id;
bool fav = false;
void _obtenerDatosFavorito() async {
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
