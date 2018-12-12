import 'package:flutter/material.dart';
import 'dart:ui';
import '../../api/baseDeDatos2.dart';
import '../../api/routes.dart';
import 'dart:async';

class HomeInicio extends StatefulWidget {
  _MyAppState _appState = _MyAppState();
  @override
  _MyAppState createState() {
    return _appState;
  }
}


class _MyAppState extends State<HomeInicio> {
  String titulo = 'xšaθrapIā';

  @override
  void initState() {
    /*
    getEstado().then((result) {
      setState(() {
        if (result==false)
          Navigator.pushNamedAndRemoveUntil(context, '/registro', (_) => false);
        else
          Navigator.pushNamedAndRemoveUntil(context, '/inicio', (_) => false);
      });
    });
    */
  }

  /*
  Future<bool> getEstado() async {
    //DBProvider db = new DBProvider();
    //await db.initDb();
    bool logeado = await DBProvider.db.isLoggedIn();
    //logeado = false;
    return logeado;
  }
  */

  Future<bool> getEstado() async {
    //DBProvider db = new DBProvider();
    //await db.initDb();
    bool logeado = await DBProvider.db.isLoggedIn();
    if (logeado==false)
        Navigator.pushNamedAndRemoveUntil(context, '/registro', (_) => false);
      else
        Navigator.pushNamedAndRemoveUntil(context, '/inicio', (_) => false);
    return logeado;
  }

  @override
  Widget build(BuildContext context) {
    new Timer(new Duration(seconds: 3), getEstado);
    return new MaterialApp(
      title: 'Satrapia',
      home: SplashScreen(titulo),
      routes: routes,
    );
  }
}

Widget SplashScreen(String texto) {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  return PantallaEspera(scaffoldKey, texto);
  /*
  return Scaffold(
    body: FutureBuilder<bool>(
      future: DBProvider.db.isLoggedIn(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == false) {
            print("Nos vamos a registro");
            //Navigator.pushNamedAndRemoveUntil(context, '/registro', (_) => false);
          }
          else {
            print("Nos vamos a inicio");
            //Navigator.pushNamedAndRemoveUntil(context, '/inicio', (_) => false);
          }
          return PantallaEspera(scaffoldKey, texto);
        }
        else {
          return PantallaEspera(scaffoldKey,texto);
        }
      },
    )
  );
  */
}


Widget PantallaEspera(scaffoldKey,texto) {
        return new Scaffold(
          appBar: null,
          key: scaffoldKey,
          body: new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: new AssetImage("imagenes/fondo_login.jpg"),
                  fit: BoxFit.cover),
            ),
            child: new Center(
              child: new ClipRect(
                child: new BackdropFilter(
                  filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: new Container(
                    child: new Center(
                      child: new Text(
                        texto,
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 36.0,
                          color: Colors.black,
                          fontFamily: "Rock Salt",
                        ),
                      ),
                    ),
                    height: 50.0,
                    width: 300.0,
                    decoration: new BoxDecoration(
                        color: Colors.grey.shade200.withOpacity(0.5)),
                  ),
                ),
              ),
            ),
          ),
        );
  }