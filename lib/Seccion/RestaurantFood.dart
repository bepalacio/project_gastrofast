import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class RestaurantFood extends StatefulWidget {
  RestaurantFood({Key key}) : super(key: key);

  @override
  _RestaurantFoodState createState() => _RestaurantFoodState();
}

class _RestaurantFoodState extends State<RestaurantFood> {
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;

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
                          Text("",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15)),
                          SizedBox(
                            width: 300.0,
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
                              child: Text(
                                  "Rica salchipapa de pollo que lleva 125g de pollo, sachicha de pavo, lechuga y salsa...."),
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
                              onPressed: () => showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: Text("Pedido Agredago al Carrito"),
                                      content: Text("Agregado Correctamente"),
                                      actions: [
                                        CupertinoDialogAction(
                                            child: Text("Ok")),
                                      ],
                                    ),
                                  )),
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
