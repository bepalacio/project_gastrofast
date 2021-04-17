import 'package:f_202110_firebase_google_login/Seccion/Restaurant.dart';
import 'package:flutter/material.dart';

class SearchRestaurant extends StatefulWidget {
  SearchRestaurant({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SearchRestaurantState createState() => _SearchRestaurantState();
}

class _SearchRestaurantState extends State<SearchRestaurant> {
  String valueChoose;
  List listItem = [
    "Item 1",
    "Item 2",
    "Item 3",
    "Item 4",
    "Item 5",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Busca aquello que deseas'),
        backgroundColor: Colors.orangeAccent,
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
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
                Text("¿Que deseas comer?",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
                SizedBox(
                  height: 15.0,
                ),
                Text("Elige tu comida",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
                SizedBox(
                  height: 15.0,
                ),
                DropdownButtonFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(20.0),
                        ),
                      ),
                    ),
                    hint: Text("Select Item: "),
                    focusColor: Colors.white,
                    dropdownColor: Colors.white,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 36,
                    isExpanded: true,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    value: valueChoose,
                    onChanged: (newValue) {
                      setState(() {
                        valueChoose = newValue;
                      });
                    },
                    items: listItem.map((valueItem) {
                      return DropdownMenuItem(
                        value: valueItem,
                        child: Text(valueItem),
                      );
                    }).toList()),
                SizedBox(
                  height: 15.0,
                ),
                SizedBox(
                  width: 310.0,
                  height: 200.0,
                  child: const Card(),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text("Define tu presupuesto:",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
                SizedBox(
                  height: 15.0,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Presupuesto",
                      filled: true,
                      fillColor: Colors.white),
                ),
                SizedBox(
                  height: 15.0,
                ),
                ElevatedButton.icon(
                  label: Text('Buscar'),
                  icon: Icon(Icons.search),
                  onPressed: () => _pushPage(context, RestaurantEncounter()),
                )
              ],
            ),
          ),
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