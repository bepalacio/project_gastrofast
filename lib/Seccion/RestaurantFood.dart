import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_202110_firebase_google_login/Seccion/RestaurantMenu.dart';
import 'package:f_202110_firebase_google_login/Seccion/RestaurantMenuFood.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'Restaurant.dart';

class RestaurantFood extends StatefulWidget {
  RestaurantFood({Key key}) : super(key: key);

  @override
  _RestaurantFoodState createState() => _RestaurantFoodState();
}

Timer _timer;

class _RestaurantFoodState extends State<RestaurantFood> {
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;
  @override
  void initState() {
    super.initState();
    //datosR.clear();
    cantidad = 0;
    _obtenerDetalleCategoria();
    _obtenerDatosCarrito();
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
    _agregarAlCarrito();
    _showMyDialog(
        context, "¡Agregado Correctamente!", "Pedido Agredago al Carrito");
  }

  @override
  Widget build(BuildContext context) {
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
                          Text("",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15)),
                          SizedBox(
                            width: 300.0,
                          ),
                          Row(
                            children: <Widget>[],
                          ),
                          Container(
                            width: 300,
                            height: 100,
                            child: Row(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    image: DecorationImage(
                                      image: NetworkImage(url),
                                      fit: BoxFit.cover,
                                    ),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 0,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Align(
                                  alignment: Alignment(0.8, 0),
                                  child: Text(controlDetails +
                                      " \n\nPrecio: " +
                                      "COP " +
                                      precio.toString()),
                                ),
                              ],
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
                            height: 40,
                            child: Align(
                              alignment: Alignment(-1, 0),
                              child: Text(" Descripcion de la comida"),
                            ),
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Color.fromRGBO(244, 202, 110, 0)),
                            padding: EdgeInsets.all(10.0),
                          ),
                          Container(
                            width: 300,
                            child: Align(
                              alignment: Alignment(-1, 0),
                              child: Text(descripcion),
                            ),
                            decoration:
                                BoxDecoration(shape: BoxShape.rectangle),
                            padding: EdgeInsets.all(10.0),
                          ),
                          SizedBox(
                            width: 300.0,
                            height: 305.0,
                          ),
                          ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromRGBO(
                                    245, 100, 90, 50), // background
                                onPrimary: Colors.white, // foreground
                              ),
                              label: Text('Agregar al Carrito'),
                              icon: Icon(Icons.add_shopping_cart),
                              onPressed: () {
                                _initializeTimer();
                              }),
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

void _agregarAlCarrito() {
  print("Cantidad: " + cantidad.toString());
  print("uid: " + uid);
  var firebaseUser = FirebaseAuth.instance.currentUser;
  if (cantidad > 0) {
    int cant = cantidad + 1;
    firestoreInstance
        .collection("Carrito")
        .doc(uid)
        .update({"Cantidad": cant}).then((_) {
      print("success!");
    });
  } else {
    int cant = cantidad + 1;
    firestoreInstance.collection("Carrito").add({
      "Restaurante": nombre,
      "Cantidad": cant,
      "Comida": controlDetails,
      "user_id": firebaseUser.uid
    }).then((value) {
      print(value.id);
    });
  }
  _obtenerDatosCarrito();
}

int cantidad;
String uid = "";

void _obtenerDatosCarrito() async {
  var firebaseUser = FirebaseAuth.instance.currentUser;

  await firestoreInstance
      .collection("Carrito")
      .where("user_id", isEqualTo: firebaseUser.uid)
      .where("Restaurante", isEqualTo: nombre)
      .where("Comida", isEqualTo: controlDetails)
      .get()
      .then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      String restaurante = result.get("Restaurante");
      String comida = result.get("Comida");
      cantidad = result.get("Cantidad");
      uid = result.id;
    });
  });
}

// void _obtenerDetalleRestaurante(String nombre) async {
//   await firestoreInstance
//       .collection("Restaurante_Details")
//       .where("Nombre", isEqualTo: nombre)
//       .get()
//       .then((querySnapshot) {
//     querySnapshot.docs.forEach((result) {
//       print(result.data());
//       nombreD = result.get("Nombre");
//       direccionD = result.get("Direccion");
//       tiempoD = result.get("Tiempo de llegada");
//       descripcionD = result.get("Descripcion");
//       ident = result.get("ID");
//     });
//     nombreD = nombreD;
//     print("Nombre D:" + nombreD);
//     print("ID:" + ident.toString());
//   });
//   _obtenerMenuRestaurante(ident);
//   print("Nombre D1:" + nombreD);
// }

final firestoreInstance = FirebaseFirestore.instance;

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
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

List detailsM = [];
String descripcion = "";
double precio = 0.0;
String url = "";
List _obtenerDetalleCategoria() {
  List restMenu = rMenu;
  List dtMenu = [];
  for (final x in restMenu) {
    //print(x);
    List menu = x.toString().split(",");

    String detalle = menu[0].toString().split(" ").join("").split("[").join("");
    print("Detalle: " + detalle);
    if (detalle == controlDetails.split(" ").join("")) {
      print(x);
      dtMenu.add(menu[0].split("[").join(""));
      print(menu[3]);
      String desc = "";
      for (var i = 3; i < menu.length - 2; i++) {
        if (i < menu.length - 3) {
          print(menu[i]);
          desc += menu[i].toString() + ",";
        } else {
          if (i == menu.length - 3) {
            desc += menu[i].toString();
          }
        }
      }
      descripcion = desc.substring(1);

      precio =
          double.parse(menu[menu.length - 1].toString().split("]").join(""));
      url = menu[menu.length - 2].toString().split("]").join("").substring(1);
      print(precio);
      print(descripcion);
      print(url);
    }
  }
  dtMenu = dtMenu.toSet().toList();
  detailsM = dtMenu;
  // print(dtMenu);
}
