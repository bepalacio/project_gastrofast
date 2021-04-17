import 'package:flutter/material.dart';
import 'package:f_202110_firebase_google_login/Seccion/PaymentMethod.dart';

class Cart extends StatefulWidget {
  Cart({Key key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
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
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        children: <Widget>[
                          Text("Carrito",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(
                            width: 300.0,
                            height: 15.0,
                          ),
                          Text("Desliza para eliminar del carrito",
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
                              child: Text(
                                  " Salchipapa Sencilla \n\n Precio: 11.900"),
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFFFFF),
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          SizedBox(
                            width: 300.0,
                            height: 20.0,
                          ),
                          SizedBox(
                            width: 300.0,
                            child: Text("Total a pagar"),
                          ),
                          SizedBox(
                            width: 300.0,
                            height: 20.0,
                          ),
                          Container(
                            width: 300,
                            height: 50,
                            child: Align(
                              alignment: Alignment(-0.9, 0),
                              child: Text(" \$ 11.900"),
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFFFFF),
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          SizedBox(
                            width: 300.0,
                            height: 20.0,
                          ),
                          Text("Cumple Con el presupuesto",
                              style: TextStyle(
                                  color: Color.fromRGBO(30, 255, 0, 100),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15)),
                          SizedBox(
                            height: 230.0,
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromRGBO(
                                  245, 100, 90, 50), // background
                              onPrimary: Colors.white, // foreground
                            ),
                            label: Text('Metodo de pago'),
                            icon: Icon(Icons.payment_sharp),
                            onPressed: () => _pushPage(context, PayMethod()),
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
