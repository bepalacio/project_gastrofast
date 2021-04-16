import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  Cart({Key key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(),
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
                          Text("Carrito de Pedidos",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15)),
                          SizedBox(
                            width: 300.0,
                            height: 15.0,
                          ),
                          Text("Desliza para eliminar",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15)),
                          SizedBox(
                            width: 300.0,
                            height: 15.0,
                          ),
                          Container(
                            width: 300.0,
                            child: Text("Hola"),
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromRGBO(
                                  245, 100, 90, 50), // background
                              onPrimary: Colors.white, // foreground
                            ),
                            label: Text('Metodo de pago'),
                            icon: Icon(Icons.payment_sharp),
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
