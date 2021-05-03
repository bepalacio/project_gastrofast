
/*

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
                Text("Detalles del restaurante",
                    style: TextStyle(color: Colors.black, fontSize: 15)),
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
                    alignment: Alignment(-1, 0),
                    child: Text("Descripcion"),
                  ),
                ),
                SizedBox(
                  width: 300.0,
                  height: 15.0,
                ),
                SliverAppBar(
                  expandedHeight: 200.0,
                )
              ],
            ),
          ),
        ),
      ),


*/