import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GooglePage extends StatefulWidget {
  final Widget child;

  GooglePage({Key key, this.child}) : super(key: key);
  _GoogleScreenState createState() => _GoogleScreenState();
}

class _GoogleScreenState extends State<GooglePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Auth'),
      ),
      body: Column(
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.all(5.0),
            width: 400.0,
            height: 400.0,
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: new AssetImage("assets/images/google.png"),
                    fit: BoxFit.cover)),
          )
        ],
      ),
    );
  }
}
