import 'package:f_202110_firebase_google_login/Seccion/RestaurantDetails.dart';
import 'package:f_202110_firebase_google_login/Seccion/RestaurantMenu.dart';
import 'package:f_202110_firebase_google_login/Seccion/RestaurantMaps.dart';
import 'package:flutter/material.dart';

class RestaurantEncounter extends StatefulWidget {
  RestaurantEncounter({Key key}) : super(key: key);

  @override
  _RestaurantEncounterState createState() => _RestaurantEncounterState();
}

class _RestaurantEncounterState extends State<RestaurantEncounter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurantes'),
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
                Text("Restaurantes encontrados",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
                SizedBox(
                  height: 15.0,
                ),
                SizedBox(
                  width: 300.0,
                  height: 150.0,
                  child: const Card(),
                ),
                SizedBox(
                  height: 15.0,
                ),
                SizedBox(
                    width: 300.0,
                    height: 150.0,
                    child: FlatButton(
                        child: Text(''),
                        color: Color.fromRGBO(136, 255, 0, 100),
                        onPressed: () => _pushPage(context, RestaurantMenu()))),
                SizedBox(
                  height: 15.0,
                ),
                SizedBox(
                  width: 300.0,
                  height: 150.0,
                  child: const Card(),
                ),
                SizedBox(
                  height: 15.0,
                ),
                ElevatedButton.icon(
                  label: Text('Ver en Mapa'),
                  icon: Icon(Icons.search),
                  onPressed: () => _pushPage(context, RestaurantMaps()),
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
