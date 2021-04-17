import 'package:f_202110_firebase_google_login/Formularios/menuLateral.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Perfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return MaterialApp(
      title: 'Perfil de usuario',
      // routes: <String, WidgetBuilder>{
      //   '/LoginPage': (BuildContext context) => new LoginPage(),
      //   '/GoogleLogin': (BuildContext context) => new GoogleLogIn(),
      //   '/Home': (BuildContext context) => new Home()
      // },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Perfil_Usuario(title: 'interface'),
    );
  }
}

class Perfil_Usuario extends StatelessWidget {
  const Perfil_Usuario({Key key, String title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Padding(
      padding: new EdgeInsets.only(top: statusBarHeight),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(244, 202, 110, 10),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 30),
              IconButton(
                  //ACA IMPORTANTE EL PARA NAVEGACION REGRESAR AL MENU PRINCIPAL
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () => _pushPage(context, MenuLateral()),
                  alignment: Alignment.centerLeft),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Text.rich(TextSpan(
                  text: 'Mi Perfil',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                )),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Detalles Personales',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 80),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Cambiar',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(254, 74, 12, 10)),
                        )),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    height: 150,
                    width: 310,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.grey),
                            child: SizedBox(
                              height: 100,
                              width: 100,
                              child: Image.network(firebaseUser.photoURL),
                              //IMPORTANTE ACA EN EL CHILD DE ESTE SIZEDBOX DEBE COLOCARSE LA IMAGEN OBTENIDA EL LOGUEO.
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //IMPORTANTE ACA, ALGUNA FUNCION EXTERNA AL CODIGO DE ESTA INTERFAZ QUE CAPTURE EL NOMBRE Y LO RETORNE Y SE LE MANDA COMO PARAMETRO AL Text
                              Text(firebaseUser.displayName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10)),
                              SizedBox(
                                width: 20,
                              ),
                              Text(firebaseUser.email,
                                  style: TextStyle(
                                    fontSize: 10,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                    ),
                    child: SizedBox(
                      width: 290,
                      child: TextButton(
                        onPressed: () {},
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Ordenes',
                                style: TextStyle(color: Colors.black)),
                            SizedBox(width: 190),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                    ),
                    child: SizedBox(
                      width: 290,
                      child: TextButton(
                        onPressed: () {},
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Pedidos Pendientes',
                                style: TextStyle(color: Colors.black)),
                            SizedBox(width: 120),
                            Icon(Icons.arrow_forward_ios, color: Colors.black)
                          ],
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                    ),
                    child: SizedBox(
                      width: 290,
                      child: TextButton(
                        onPressed: () {},
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Lista de favoritos',
                                style: TextStyle(color: Colors.black)),
                            SizedBox(width: 132),
                            Icon(Icons.arrow_forward_ios, color: Colors.black)
                          ],
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                    ),
                    child: SizedBox(
                      width: 290,
                      child: TextButton(
                        onPressed: () {},
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Ayuda',
                                style: TextStyle(color: Colors.black)),
                            SizedBox(width: 200),
                            Icon(Icons.arrow_forward_ios, color: Colors.black),
                          ],
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromRGBO(254, 74, 12, 10), width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color.fromRGBO(254, 74, 12, 10),
                    ),
                    child: SizedBox(
                      width: 290,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Color.fromRGBO(254, 74, 12, 10),
                          primary: Colors.teal,
                        ),
                        onPressed: () {},
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('ACTUALIZAR',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
        //
      ),
    );
  }
}

void _pushPage(BuildContext context, Widget page) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(builder: (_) => page),
  );
}
