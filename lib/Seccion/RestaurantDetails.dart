import 'package:flutter/material.dart';

/// This is the main application widget.

/// This is the stateful widget that the main application instantiates.
class RestaurantDetails extends StatefulWidget {
  const RestaurantDetails({Key key}) : super(key: key);

  @override
  _RestaurantDetailsState createState() => _RestaurantDetailsState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _RestaurantDetailsState extends State<RestaurantDetails> {
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;

// [SliverAppBar]s are typically used in [CustomScrollView.slivers], which in
// turn can be placed in a [Scaffold.body].
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: _pinned,
            snap: _snap,
            floating: _floating,
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
                          Text("Detalles del restaurante",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15)),
                          SizedBox(
                            width: 300.0,
                            height: 15.0,
                          ),
                          Container(
                            width: 300,
                            height: 100,
                            child: Align(
                              alignment: Alignment(0.8, 0),
                              child: Text(
                                  " Nombre Restaurante \n\n Direccion: \n\n Tiempo: ##:## \n"),
                            ),
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle, color: Colors.white),
                            padding: EdgeInsets.all(10.0),
                          ),
                          SizedBox(
                            width: 300.0,
                            height: 15.0,
                          ),
                          Container(
                            width: 300,
                            height: 20,
                            child: Align(
                              alignment: Alignment(-1, -1),
                              child: Text("Descripcion"),
                            ),
                          ),
                          Container(
                            width: 300,
                            child: Align(
                              alignment: Alignment(-1, -1),
                              child: Text(
                                  "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur? "),
                            ),
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle, color: Colors.white),
                            padding: EdgeInsets.all(10.0),
                          ),
                          SizedBox(
                            width: 300.0,
                            height: 15.0,
                          ),
                          MaterialButton(
                            minWidth: 300.0,
                            height: 40.0,
                            onPressed: () {},
                            color: Colors.blue[900],
                            child: Text('Facebook',
                                style: TextStyle(color: Colors.white)),
                          ),
                          MaterialButton(
                            minWidth: 300.0,
                            height: 40.0,
                            onPressed: () {},
                            color: Colors.red[400],
                            child: Text('Instagram',
                                style: TextStyle(color: Colors.white)),
                          ),
                          MaterialButton(
                            minWidth: 300.0,
                            height: 40.0,
                            onPressed: () {},
                            color: Colors.lightGreenAccent[700],
                            child: Text('Whatsapp',
                                style: TextStyle(color: Colors.white)),
                          ),
                          Container()
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
