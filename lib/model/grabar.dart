import 'package:cloud_firestore/cloud_firestore.dart';

class Grabar {
  final String name;
  final String username;
  final String correo;
  final String pass;
  final DocumentReference reference;

  Grabar.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['username'] != null),
        assert(map['correo'] != null),
        assert(map['contraseña'] != null),
        name = map['name'],
        username = map['username'],
        correo = map['correo'],
        pass = map['contraseña'];

  Grabar.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$username>";
}
