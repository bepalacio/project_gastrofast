import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_202110_firebase_google_login/model/grabar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prompt_dialog/prompt_dialog.dart';

class FireStore extends StatelessWidget {
  CollectionReference user = FirebaseFirestore.instance.collection('baby');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('user').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.docs);
      },
    );
  }

  // Future<void> addUser(BuildContext context) {
  //   getUser(context).then((value) {
  //     return user
  //         .add({'name': value, 'username': ''})
  //         .then((value) => print("User added"))
  //         .catchError((onError) => print("Failed to add user$onError"));
  //   });
  // }

  Future<void> getUser(BuildContext context) async {
    String result = await prompt(
      context,
      title: Text('Agregando un usuario'),
      initialValue: '',
      textOK: Text('Ok'),
      textCancel: Text('Cancel'),
      hintText: 'Baby name',
      minLines: 1,
      autoFocus: true,
      obscureText: false,
      textCapitalization: TextCapitalization.words,
    );
    if (result != null) {
      return Future.value(result);
    }
    return Future.error('cancel');
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return Scaffold(
        body: ListView(
      padding: EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildItem(context, data)).toList(),
    ));
  }

  Widget _buildItem(BuildContext context, DocumentSnapshot data) {
    final grabar = Grabar.fromSnapshot(data);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5.0)),
        child: ListTile(
          title: Text(grabar.name),
          trailing: Text(grabar.username),
        ),
      ),
    );
  }
}
