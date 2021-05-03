import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmailPage extends StatefulWidget {
  final Widget child;

  EmailPage({Key key, this.child}) : super(key: key);
  _EmailScreenState createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email Auth'),
      ),
      body: Column(
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.all(5.0),
            width: 400.0,
            height: 400.0,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: new AssetImage("assets/images/correo.png"),
                  fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }
}
