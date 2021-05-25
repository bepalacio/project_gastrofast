import 'package:f_202110_firebase_google_login/Formularios/perfil.dart';
import 'package:flutter/material.dart';
import 'package:favorite_button/favorite_button.dart';

class ListFavorite extends StatefulWidget {
  ListFavorite({Key key}) : super(key: key);

  @override
  _FavoritosState createState() => _FavoritosState();
}

class _FavoritosState extends State<ListFavorite> {
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
                          Text("Restaurantes Favoritos ⭐",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 300.0,
                            height: 15.0,
                          ),
                          Column(
                            children: favorito1.map((items) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.redAccent,
                                    width: 1,
                                  ),
                                ),
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 10, bottom: 10),
                                width: 300,
                                height: 100,
                                //color: Colors.white,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        /*
                                      image: const DecorationImage(
                                        image: AssetImage(
                                            "assets/Comida/pizza.png"),
                                        fit: BoxFit.cover,
                                      ),
                                      */
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color:
                                              Color.fromRGBO(229, 147, 40, 1),
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    RichText(
                                      text: new TextSpan(
                                        // Note: Styles for TextSpans must be explicitly defined.
                                        // Child text spans will inherit styles from parent
                                        style: new TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black,
                                        ),
                                        children: <TextSpan>[
                                          new TextSpan(
                                              text: "Nombre: " +
                                                  items["nombre"] +
                                                  "\n\n",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold)),
                                          new TextSpan(
                                              text: 'Direccion: ' +
                                                  items["direccion"] +
                                                  "\n\n",
                                              style: new TextStyle(
                                                  color: Colors.orange,
                                                  fontWeight: FontWeight.bold)),
                                          new TextSpan(
                                              text: 'Tiempo: ' +
                                                  items["tiempo"].toString() +
                                                  "\n\n",
                                              style: new TextStyle(
                                                  color: Colors.orange,
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                          SizedBox(
                            width: 300.0,
                            height: 15.0,
                          ),
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
