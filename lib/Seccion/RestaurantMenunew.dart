import 'package:flutter/material.dart';

class NewMenu extends StatefulWidget {
  NewMenu({Key key}) : super(key: key);

  @override
  _NewMenuState createState() => _NewMenuState();
}

const String Nombre = "Nombre de la comida";
const String Precio = "Precio";

class _NewMenuState extends State<NewMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                            Row(
                              children: [
                                Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/images/logo_app.png"),
                                      fit: BoxFit.cover,
                                    ),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                        child: Text(
                                      "\n\n Nombre: \n\n"
                                      " Direccion: \n\n"
                                      " Tiempo: \n\n",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    )),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 300.0,
                              height: 15.0,
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(children: <Widget>[
                                Text(
                                  "Menu del restaurante",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                //Elemento del Menu
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 30, top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color.fromRGBO(255, 150, 136, 1),
                                      width: 5,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          image: const DecorationImage(
                                            image: AssetImage(
                                                "assets/Comida/pizza.png"),
                                            fit: BoxFit.cover,
                                          ),
                                          border: Border.all(
                                            color:
                                                Color.fromRGBO(229, 147, 40, 1),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            child: RichText(
                                              text: new TextSpan(
                                                // Note: Styles for TextSpans must be explicitly defined.
                                                // Child text spans will inherit styles from parent
                                                style: new TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.black,
                                                ),
                                                children: <TextSpan>[
                                                  new TextSpan(
                                                      text:
                                                          'Nombre de la comida \n',
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  new TextSpan(
                                                      text: 'Precio: ',
                                                      style: new TextStyle(
                                                          color: Colors.orange,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                //Nuevo Elemento del menu
                                //________________________________________________________________
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 30, top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color.fromRGBO(255, 150, 136, 1),
                                      width: 5,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          image: const DecorationImage(
                                            image: AssetImage(
                                                "assets/Comida/pizza.png"),
                                            fit: BoxFit.cover,
                                          ),
                                          border: Border.all(
                                            color:
                                                Color.fromRGBO(229, 147, 40, 1),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            child: RichText(
                                              text: new TextSpan(
                                                // Note: Styles for TextSpans must be explicitly defined.
                                                // Child text spans will inherit styles from parent
                                                style: new TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.black,
                                                ),
                                                children: <TextSpan>[
                                                  new TextSpan(
                                                      text:
                                                          'Nombre de la comida \n',
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  new TextSpan(
                                                      text: 'Precio: ',
                                                      style: new TextStyle(
                                                          color: Colors.orange,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                //Otro
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 30, top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color.fromRGBO(255, 150, 136, 1),
                                      width: 5,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          image: const DecorationImage(
                                            image: AssetImage(
                                                "assets/Comida/pizza.png"),
                                            fit: BoxFit.cover,
                                          ),
                                          border: Border.all(
                                            color:
                                                Color.fromRGBO(229, 147, 40, 1),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            child: RichText(
                                              text: new TextSpan(
                                                // Note: Styles for TextSpans must be explicitly defined.
                                                // Child text spans will inherit styles from parent
                                                style: new TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.black,
                                                ),
                                                children: <TextSpan>[
                                                  new TextSpan(
                                                      text:
                                                          'Nombre de la comida \n',
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  new TextSpan(
                                                      text: 'Precio: ',
                                                      style: new TextStyle(
                                                          color: Colors.orange,
                                                          fontWeight:
                                                              FontWeight.bold)),
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
                                  height: 20,
                                ),
                              ]),
                            ),
                            Column(
                              children: [
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromRGBO(
                                        245, 100, 90, 50), // background
                                    onPrimary: Colors.white, // foreground
                                  ),
                                  label: Text('Ver Carrito'),
                                  icon: Icon(Icons.add_shopping_cart),
                                  onPressed: () => null,
                                )
                              ],
                            ),
                          ],
                        )),
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
