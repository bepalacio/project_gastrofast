import 'package:f_202110_firebase_google_login/Seccion/RestaurantMenuFood.dart';
import 'package:f_202110_firebase_google_login/Seccion/Cart.dart';
import 'package:flutter/material.dart';

/// This is the main application widget.

/// This is the stateful widget that the main application instantiates.
class RestaurantMenu extends StatefulWidget {
  const RestaurantMenu({Key key}) : super(key: key);

  @override
  _RestaurantMenuState createState() => _RestaurantMenuState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _RestaurantMenuState extends State<RestaurantMenu> {
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
                          Text("Menu del restaurante",
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
                                  " Nombre Restaurante \n\n Direccion: \n\n Tiempo: ##:## \n"),
                            ),
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle, color: Colors.white),
                            padding: EdgeInsets.all(10.0),
                          ),
                          SizedBox(
                            width: 300.0,
                            height: 15.0,
                          ),
                          SizedBox(
                              width: 300.0,
                              height: 100.0,
                              child: FlatButton(
                                  child: Text('Salchipapas'),
                                  color: Color.fromRGBO(255, 214, 0, 100),
                                  onPressed: () => _pushPage(
                                      context, RestaurantMenuFood()))),
                          SizedBox(
                            width: 300.0,
                            height: 15.0,
                          ),
                          SizedBox(
                              width: 300.0,
                              height: 100.0,
                              child: FlatButton(
                                  child: Text('Perros'),
                                  color: Color.fromRGBO(237, 118, 118, 100),
                                  onPressed: () => null)),
                          SizedBox(
                            width: 300.0,
                            height: 15.0,
                          ),
                          SizedBox(
                              width: 300.0,
                              height: 100.0,
                              child: FlatButton(
                                  child: Text('Pizzas'),
                                  color: Color.fromRGBO(255, 214, 0, 100),
                                  onPressed: () => null)),
                          SizedBox(
                            width: 300.0,
                            height: 15.0,
                          ),
                          SizedBox(
                              width: 300.0,
                              height: 100.0,
                              child: FlatButton(
                                  child: Text('Desgranados'),
                                  color: Color.fromRGBO(237, 118, 118, 100),
                                  onPressed: () => null)),
                          SizedBox(
                            width: 300.0,
                            height: 15.0,
                          ),
                          SizedBox(
                              width: 300.0,
                              height: 100.0,
                              child: FlatButton(
                                  child: Text('Hamburguesa'),
                                  color: Color.fromRGBO(255, 214, 0, 100),
                                  onPressed: () => null)),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromRGBO(
                                  245, 100, 90, 50), // background
                              onPrimary: Colors.white, // foreground
                            ),
                            label: Text('Ver Carrito'),
                            icon: Icon(Icons.add_shopping_cart),
                            onPressed: () => _pushPage(context, Cart()),
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