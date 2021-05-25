import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_202110_firebase_google_login/Formularios/menuLateral.dart';
import 'package:f_202110_firebase_google_login/Seccion/Restaurant.dart';
import 'package:f_202110_firebase_google_login/Seccion/RestaurantMenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

class PayMethod extends StatefulWidget {
  PayMethod({Key key}) : super(key: key);

  @override
  _PayMethodState createState() => _PayMethodState();
}

Timer _timer;

class _PayMethodState extends State<PayMethod> {
  int selected_radio;
  int selected_radio_one;
  @override
  void initState() {
    selected_radio = 0;
    selected_radio_one = 0;
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
    _procederPago();
    _initializeTimer1();
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
    _obtenerDatosCarrito();
    _showMyDialog(context, "¡Compra realizada correctamente!", "Compra");
  }

  void setSelectedRadio(int val) {
    if (val == 1) metdPago = "Cuenta Bancaria";
    if (val == 2) metdPago = "Nequi";
    if (val == 3) metdPago = "Efectivo";
    setState(() {
      selected_radio = val;
    });
  }

  void setSelectedRadio1(int val) {
    if (val == 1) metdEntrega = "Entrega a casa";
    if (val == 2) metdEntrega = "Recoger";
    setState(() {
      selected_radio_one = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
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
                    padding: const EdgeInsets.all(1),
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Metodo de pago",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(
                            width: 300.0,
                            height: 15.0,
                          ),
                          Text(
                              "Escoge el metodo por el cual deseas pagar el pedido",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15)),
                          SizedBox(
                            width: 300.0,
                            height: 15.0,
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            child: Row(
                              children: [
                                Radio(
                                    value: 1,
                                    groupValue: selected_radio,
                                    activeColor: Colors.orange,
                                    onChanged: (val) {
                                      setSelectedRadio(val);
                                      print("selected_radio: " +
                                          selected_radio.toString());
                                    }),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Colors.orange[300],
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(5),
                                            bottomRight: Radius.circular(5),
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5))),
                                    child: Icon(
                                      Icons.credit_card_outlined,
                                      size: 40,
                                    )),
                                Container(
                                  padding: EdgeInsets.all(12),
                                  child: Text(
                                    "Cuenta Bancaria",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                              color: Colors.white,
                              child: Divider(
                                color: Colors.grey[300],
                                height: 10,
                                thickness: 2,
                                indent: 20,
                                endIndent: 20,
                              )),
                          Container(
                            padding: EdgeInsets.all(10),
                            color: Colors.white,
                            child: Row(
                              children: [
                                Radio(
                                    value: 2,
                                    groupValue: selected_radio,
                                    activeColor: Colors.orange,
                                    onChanged: (val) {
                                      setSelectedRadio(val);
                                    }),
                                Container(
                                  height: 40.0,
                                  width: 40.0,
                                  decoration: BoxDecoration(
                                    color: Colors.orange[300],
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(5),
                                        bottomRight: Radius.circular(5),
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5)),
                                    image: DecorationImage(
                                      alignment: Alignment.center,
                                      matchTextDirection: true,
                                      repeat: ImageRepeat.noRepeat,
                                      image: AssetImage(
                                          "assets/Imagenes/NequiLogo.png"),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(12),
                                  child: Text(
                                    "Nequi",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            child: Divider(
                              color: Colors.grey[300],
                              height: 10,
                              thickness: 2,
                              indent: 20,
                              endIndent: 20,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20))),
                            child: Row(
                              children: [
                                Radio(
                                    value: 3,
                                    groupValue: selected_radio,
                                    activeColor: Colors.orange,
                                    onChanged: (val) {
                                      setSelectedRadio(val);
                                    }),
                                Container(
                                    padding: EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                        color: Colors.orange[300],
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(5),
                                            bottomRight: Radius.circular(5),
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5))),
                                    child: Icon(
                                      Icons.attach_money_rounded,
                                      size: 40,
                                    )),
                                Container(
                                  padding: EdgeInsets.all(12),
                                  child: Text(
                                    "Efectivo",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text("Metodo de entrega",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15)),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            child: Row(
                              children: [
                                Radio(
                                    value: 1,
                                    groupValue: selected_radio_one,
                                    activeColor: Colors.orange,
                                    onChanged: (val) {
                                      setSelectedRadio1(val);
                                    }),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Colors.orange[300],
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(5),
                                            bottomRight: Radius.circular(5),
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5))),
                                    child: Icon(
                                      Icons.motorcycle_rounded,
                                      size: 40,
                                    )),
                                Container(
                                  padding: EdgeInsets.all(12),
                                  child: Text(
                                    "Entrega a casa",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            child: Divider(
                              color: Colors.grey[300],
                              height: 10,
                              thickness: 2,
                              indent: 20,
                              endIndent: 20,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20))),
                            child: Row(
                              children: [
                                Radio(
                                    value: 2,
                                    groupValue: selected_radio_one,
                                    activeColor: Colors.orange,
                                    onChanged: (val) {
                                      setSelectedRadio1(val);
                                    }),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Colors.orange[300],
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(5),
                                            bottomRight: Radius.circular(5),
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5))),
                                    child: Icon(
                                      Icons.shopping_bag_outlined,
                                      size: 40,
                                    )),
                                Container(
                                  padding: EdgeInsets.all(12),
                                  child: Text(
                                    "Recoger",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                              child: Row(
                            children: [
                              Text(
                                "Total a pagar:",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16),
                              ),
                              Spacer(),
                              Text(
                                "\u0024 " + total.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                          MaterialButton(
                            onPressed: () {
                              print("Metodo de pago: " + metdPago);
                              print("Metodo de Entrega: " + metdEntrega);
                              if (selected_radio != 0 &&
                                  selected_radio_one != 0) {
                                _initializeTimer();
                              }
                            },
                            color: Colors.red[400],
                            height: 40,
                            minWidth: double.infinity,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Text(
                              "Proceder con el pago",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0),
                            ),
                          ),
                          SizedBox(
                            height: 50,
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

final firestoreInstance = FirebaseFirestore.instance;

void _pushPage(BuildContext context, Widget page) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(builder: (_) => page),
  );
}

String metdPago = "";
String metdEntrega = "";

void _procederPago() {
  firestoreInstance.collection("Compras").add({
    "Metodo_Pago": metdPago,
    "Metodo_entrega": metdEntrega,
    "Detalle": body
  }).then((value) {
    print("¡Pagado!");
  });
}

void _eliminarDelCarrito(String id) {
  firestoreInstance.collection("Carrito").doc(id).delete().then((_) {
    print("Eliminado!");
  });
}

List uidC;
void _obtenerDatosCarrito() async {
  var firebaseUser = FirebaseAuth.instance.currentUser;

  await firestoreInstance
      .collection("Carrito")
      .where("Restaurante", isEqualTo: nombre)
      .where("user_id", isEqualTo: firebaseUser.uid)
      .get()
      .then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      _eliminarDelCarrito(result.id);
    });
  });
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
            child: Text('OK'),
            onPressed: () {
              _pushPage(context, MenuLateral());
              // Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
