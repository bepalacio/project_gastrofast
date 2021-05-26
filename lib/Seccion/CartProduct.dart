import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_202110_firebase_google_login/Seccion/PaymentMethod.dart';
import 'package:f_202110_firebase_google_login/Seccion/RestaurantMenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'RestaurantMenuFood.dart';

class CartProduct extends StatefulWidget {
  CartProduct({Key key}) : super(key: key);

  @override
  _CartProductState createState() => _CartProductState();
}

Timer _timer;

class _CartProductState extends State<CartProduct> {
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;
  @override
  void initState() {
    super.initState();
    //datosR.clear();
    _initializeTimer();
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
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
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
                      colors: [Colors.white, Colors.white],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Carrito de Compras",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 21.0,
                          ),
                        ),
                        SizedBox(
                          height: 18.0,
                        ),
                        Column(
                          children: carro1.map((items) {
                            // items.toMap();
                            return Row(
                              children: <Widget>[
                                Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                      color: Colors.green[300],
                                      image: DecorationImage(
                                        image: NetworkImage(items["imagen"]),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: Center(
                                    child: Container(
                                      width: 70,
                                      height: 70,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 12.0,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          items["comida"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 0)),
                                          Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: 15.0,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text(
                                              items["cantidad"].toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0),
                                            ),
                                          ),
                                          Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                                color: Colors.blue[300],
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: 15.0,
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            "\u0024 " +
                                                (items["precio"] *
                                                        items["cantidad"])
                                                    .toString(),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            );
                          }).toList(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Sub Total",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "\u0024 " + s_total.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Delivery Total",
                              style: TextStyle(fontWeight: FontWeight.normal),
                            ),
                            Text(
                              "\u0024 3000",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15.0),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "\u0024 " + total.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        MaterialButton(
                          onPressed: () => _pushPage(context, PayMethod()),
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
                          height: 18.0,
                        )
                      ],
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

class CartItem extends StatelessWidget {
  const CartItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: ListView(),
    );
  }
}
