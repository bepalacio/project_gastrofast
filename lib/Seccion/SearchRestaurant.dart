import 'package:f_202110_firebase_google_login/Seccion/Restaurant.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchRestaurant extends StatefulWidget {
  SearchRestaurant({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SearchRestaurantState createState() => _SearchRestaurantState();
}

final firestoreInstance = FirebaseFirestore.instance;
List categories = [];

class _SearchRestaurantState extends State<SearchRestaurant> {
  String valueChoose;
  List tags = new List();
  List<String> tagscompare = new List();
  int count;

  void initState() {
    super.initState();
    count = 0;
    categories = [];
    comida = [
      "Pizza",
      "Perro",
      "Salchipapa",
      "Pollo",
      "Pescado",
      "Arroz",
      "Hamburguesa"
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Busca aquello que deseas'),
        backgroundColor: Color.fromRGBO(245, 100, 90, 50),
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
                //--------//
                //COMBOBOX//
                //--------//
                DropDownField(
                  controller: foodselected,
                  hintText: "Selecciona tu comida",
                  enabled: true,
                  items: comida,
                  onValueChanged: (value) {
                    bool s = false;
                    setState(() {
                      if (count == 0) {
                        tagscompare.add(value);
                        tags.add(Item(title: value));
                        categories.add(Item(title: value));
                        count = count + 1;
                      } else {
                        for (int i = 0; i < tagscompare.length; i++) {
                          if (tagscompare[i] == value) {
                            s = true;
                          }
                        }
                        if (s) {
                          //No agregar Item
                        } else {
                          tagscompare.add(value);
                          tags.add(Item(title: value));
                          categories.add(Item(title: value));
                        }
                      }
                    });
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  child: Tags(
                    itemCount: tags.length,
                    columns: 6,
                    itemBuilder: (index) {
                      final Item currentItem = tags[index];
                      return ItemTags(
                        index: index,
                        title: currentItem.title,
                        customData: currentItem.customData,
                        textStyle: TextStyle(fontSize: 14),
                        combine: ItemTagsCombine.withTextBefore,
                        onPressed: (i) => print(i),
                        onLongPressed: (i) => print(i),
                        removeButton: ItemTagsRemoveButton(onRemoved: () {
                          setState(() {
                            tags.removeAt(index);
                            tagscompare.removeAt(index);
                            categories.removeAt(index);
                          });
                          return true;
                        }),
                      );
                    },
                  ),
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
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(245, 100, 90, 50), // background
                    onPrimary: Colors.white, // foreground
                  ),
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

String selec_food = "";
void _pushPage(BuildContext context, Widget page) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(builder: (_) => page),
  );
}

final foodselected = TextEditingController();
List<String> comida = [];
