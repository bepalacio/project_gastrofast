import 'package:f_202110_firebase_google_login/Seccion/CartProduct.dart';
import 'package:flutter/material.dart';
import 'package:f_202110_firebase_google_login/Seccion/RestaurantFood.dart';
import 'package:f_202110_firebase_google_login/Seccion/Cart.dart';

import 'Restaurant.dart';
import 'RestaurantMenu.dart';

/// This is the main application widget.

/// This is the stateful widget that the main application instantiates.
class RestaurantMenuFood extends StatefulWidget {
  const RestaurantMenuFood({Key key}) : super(key: key);

  @override
  _RestaurantMenuFoodState createState() => _RestaurantMenuFoodState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _RestaurantMenuFoodState extends State<RestaurantMenuFood> {
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;
  @override
  void initState() {
    super.initState();
    //datosR.clear();
    _obtenerDatosCategoria();
  }

// [SliverAppBar]s are typically used in [CustomScrollView.slivers], which in
// turn can be placed in a [Scaffold.body].
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(244, 202, 110, 100),
        child: CustomScrollView(
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
                    // decoration: BoxDecoration(
                    //   gradient: LinearGradient(
                    //     begin: Alignment.topCenter,
                    //     end: Alignment.bottomCenter,
                    //     colors: [
                    //       Color.fromRGBO(244, 202, 110, 100),
                    //       Color.fromRGBO(244, 202, 110, 100),
                    //     ],
                    //   ),
                    // ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Column(
                          children: <Widget>[
                            Text("Menu del restaurante",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15)),
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
                                                  " minutos",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            ))),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 400.0,
                              height: 15.0,
                            ),
                            Container(
                              width: 400,
                              height: 60,
                              child: Align(
                                child: Text(
                                  controlMenu,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Colors.white),
                              padding: EdgeInsets.all(10.0),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(0),
                              ),
                              child: Column(
                                  children: datosMenu.map((text) {
                                return SizedBox(
                                  child: FlatButton(
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            width: 500,
                                            padding: EdgeInsets.only(
                                                left: 5,
                                                right: 20,
                                                top: 10,
                                                bottom: 10),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Color.fromRGBO(
                                                    255, 150, 136, 1),
                                                width: 4,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    image:
                                                        const DecorationImage(
                                                      image: AssetImage(
                                                          "assets/Comida/pizza.png"),
                                                      fit: BoxFit.cover,
                                                    ),
                                                    border: Border.all(
                                                      color: Color.fromRGBO(
                                                          229, 147, 40, 1),
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Container(
                                                      child: RichText(
                                                        text: new TextSpan(
                                                          text: '\n',
                                                          // Note: Styles for TextSpans must be explicitly defined.
                                                          // Child text spans will inherit styles from parent
                                                          style: new TextStyle(
                                                            fontSize: 12.0,
                                                            color: Colors.black,
                                                          ),
                                                          children: <TextSpan>[
                                                            new TextSpan(
                                                                text:
                                                                    text.toString() +
                                                                        '\n',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                      onPressed: () {
                                        _pushPage(context, RestaurantFood());

                                        controlDetails = text.toString();
                                      }),
                                );
                              }).toList()),
                            ),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromRGBO(
                                    245, 100, 90, 50), // background
                                onPrimary: Colors.white, // foreground
                              ),
                              label: Text('Ver Carrito'),
                              icon: Icon(Icons.add_shopping_cart),
                              onPressed: () =>
                                  _pushPage(context, CartProduct()),
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
      ),
    );
  }
}

void _pushPage(BuildContext context, Widget page) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(builder: (_) => page),
  );
}

List datosMenu = [];
String controlDetails = "";
List _obtenerDatosCategoria() {
  List restMenu = rMenu;
  List dMenu = [];
  for (final x in restMenu) {
    //print(x);
    List menu = x.toString().split(",");

    String categoria = menu[1].toString().split(" ").join("");
    if (categoria == controlMenu) {
      dMenu.add(menu[0].split("(").join(""));
    }
  }
  dMenu = dMenu.toSet().toList();
  datosMenu = dMenu;
  print(dMenu);
}
