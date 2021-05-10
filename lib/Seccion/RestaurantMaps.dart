import 'package:flutter/material.dart';

class RestaurantMaps extends StatefulWidget {
  RestaurantMaps({Key key}) : super(key: key);

  @override
  _RestaurantMaps createState() => _RestaurantMaps();
}

class _RestaurantMaps extends State<RestaurantMaps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ubicacion de restaurantes'),
        backgroundColor: Color.fromRGBO(245, 100, 90, 50),
      ),
    );
  }
}
