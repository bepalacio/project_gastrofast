import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_202110_firebase_google_login/Seccion/CartProduct.dart';
import 'package:f_202110_firebase_google_login/Seccion/RestaurantMenuFood.dart';
import 'package:f_202110_firebase_google_login/Seccion/Cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Restaurant.dart';

/// This is the main application widget.

/// This is the stateful widget that the main application instantiates.
class RestaurantMenu extends StatefulWidget {
  const RestaurantMenu({Key key}) : super(key: key);

  @override
  _RestaurantMenuState createState() => _RestaurantMenuState();
}

Timer _timer;

/// This is the private State class that goes with MyStatefulWidget.
class _RestaurantMenuState extends State<RestaurantMenu> {
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;

  @override
  void initState() {
    super.initState();
    //datosR.clear();
    _obtenerDatosRestaurante();
    _obtenerDatosMenu();
  }

  void _initializeTimer1() {
    if (_timer != null) {
      _timer.cancel();
    }
    // acción de configuración después de 5 minutos
    _timer = Timer(const Duration(seconds: 2), () => _handleInactivity1());
  }

  void _handleInactivity1() {
    _timer?.cancel();
    _timer = null;
    _pushPage(context, CartProduct());
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
    _addBody();
    _initializeTimer1();
  }

// [SliverAppBar]s are typically used in [CustomScrollView.slivers], which in
// turn can be placed in a [Scaffold.body].
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
                          Text("Categorias de Comidas",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15)),
                          SizedBox(
                            width: 300.0,
                            height: 15.0,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  image: const DecorationImage(
                                    image: AssetImage(
                                        "assets/images/logo_app.png"),
                                    fit: BoxFit.cover,
                                  ),
                                  border: Border.all(
                                    color: Color.fromRGBO(229, 147, 40, 1),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Row(
                                children: [
                                  Container(
                                      child: Align(
                                          alignment: Alignment(0.8, 0),
                                          child: Text(
                                            " Nombre: " +
                                                nombre +
                                                " \n\n Direccion: " +
                                                direccion +
                                                " \n\n Tiempo: " +
                                                tiempo.toString() +
                                                " minutos ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ))),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 300.0,
                            height: 15.0,
                          ),
                          SizedBox(
                            width: 300.0,
                            height: 15.0,
                          ),
                          Column(
                              children: categoriasM.map((text) {
                            return SizedBox(
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Container(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      width: 300.0,
                                      height: 100.0,
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 80,
                                            height: 80,
                                            decoration: BoxDecoration(
                                              color: Colors.yellow[100],
                                              border: Border.all(
                                                color: Colors.amber,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                          ),
                                          FlatButton(
                                              child: Text(
                                                text.toString(),
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: Colors.redAccent),
                                              ),
                                              color: Colors.white,
                                              onPressed: () {
                                                _pushPage(context,
                                                    RestaurantMenuFood());

                                                controlMenu = text.toString();
                                              })
                                        ],
                                      )),
                                ],
                              ),
                            );
                          }).toList()),
                          SizedBox(
                            height: 10.0,
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromRGBO(
                                  245, 100, 90, 50), // background
                              onPrimary: Colors.white, // foreground
                            ),
                            label: Text('Ver Carrito'),
                            icon: Icon(Icons.add_shopping_cart),
                            onPressed: () {
                              if (body != null) {
                                body.clear();
                                s_total = 0;
                                total = 0;
                              }

                              _obtenerDatosCarrito();
                              _initializeTimer();
                            },
                          )
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

void _pushPage(BuildContext context, Widget page) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(builder: (_) => page),
  );
}

final firestoreInstance = FirebaseFirestore.instance;
String nombre;
String direccion;
double tiempo;
int id;
String controlMenu = "";
List _obtenerDatosRestaurante() {
  List restaurante = rest;
  for (final x in restaurante) {
    List r = x.toString().split(",");
    String nom = r[0].toString().substring(1);
    if (nom == control) {
      print(x);
      print(nom);
      nombre = nom;
      direccion = r[2].toString();
      tiempo = double.parse(r[1].toString());
      id = int.parse(r[3].toString().split(")").join(""));
      print(id.toString());
    }
  }
}

List categoriasM = [];
List _obtenerDatosMenu() {
  List restMenu = rMenu;
  List cate = [];
  for (final x in restMenu) {
    //print(x);
    List menu = x.toString().split(",");

    int ids = int.parse(menu[2].toString().split(" ").join(""));
    if (ids == id) {
      cate.add(menu[1].split(" ").join(""));
    }
  }
  cate = cate.toSet().toList();
  categoriasM = cate;
  print(cate);
}

final List carro = [];
double s_total = 0;
double total = 0;
Map<String, dynamic> body;
var carro1 = [];
void _obtenerDatosCarrito() {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  print("Control nombre: " + control);
  firestoreInstance
      .collection("Carrito")
      .where("user_id", isEqualTo: firebaseUser.uid)
      .where("Restaurante", isEqualTo: control)
      .get()
      .then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      String restaurante = result.get("Restaurante");
      String comida = result.get("Comida");
      String user_id = result.get("user_id");
      double precio = result.get("Precio");
      String imagen = result.get("Imagen");
      int cantidad = result.get("Cantidad");
      List data = [];
      s_total = s_total + precio;
      data.add(restaurante);
      data.add(comida);
      data.add(cantidad);
      print("data");
      print("Restaurante...: " + restaurante);
      // print(data);
      carro.add(MostrandoCarrito(
          user_id, restaurante, comida, cantidad, precio, imagen));
    });
  });
}

void _addBody() {
  print(carro);
  body = {"Comidas": []};
  carro1 = carro.map((comida) => comida.toMap()).toList();
  body['Comidas'].addAll(carro1);
  print("Comidas.......");
  print('${body['Comidas']}');
  total = s_total + 3000;
  // print(carro1);
  carro.clear();
}

class MostrandoCarrito {
  final int cantidad;
  final String user_id;
  final String restaurante;
  final String comida;
  final double precio;
  final String imagen;

  MostrandoCarrito(this.user_id, this.restaurante, this.comida, this.cantidad,
      this.precio, this.imagen);

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user_id'] = this.user_id;
    data['restaurante'] = this.restaurante;
    data['comida'] = this.comida;
    data['cantidad'] = this.cantidad;
    data['precio'] = this.precio;
    data['imagen'] = this.imagen;
    return data;
  }
}
