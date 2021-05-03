import 'package:flutter/material.dart';

class Search_Restaurant extends StatefulWidget {
  Search_Restaurant({Key key}) : super(key: key);

  @override
  _Search_RestaurantState createState() => _Search_RestaurantState();
}

class _Search_RestaurantState extends State<Search_Restaurant> {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buscar"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }
}
