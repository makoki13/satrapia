import 'package:flutter/material.dart';
import 'dart:ui';
import '../../api/baseDeDatos.dart';
import '../../api/routes.dart';

class HomeInicio extends StatefulWidget {
  _MyAppState _appState = _MyAppState();
  @override
  _MyAppState createState() {
    return _appState;
  }
}


class _MyAppState extends State<HomeInicio> {
  String titulo = ''; //'xšaθrapIā'

  @override
  void initState() {
    getEstado().then((result) {
      setState(() {
        if (result==false)
          Navigator.pushNamedAndRemoveUntil(context, '/registro', (_) => false);
        else
          Navigator.pushNamedAndRemoveUntil(context, '/inicio', (_) => false);
      });
    });
  }

  Future<bool> getEstado() async {
    BaseDeDatos db = new BaseDeDatos();
    await db.initDb();
    bool logeado = await db.isLoggedIn();
    //logeado = false;
    return logeado;
  }

  @override
  Widget build(BuildContext context) {
    //veteInicio(context);
    return new MaterialApp(
      title: 'Satrapia',
      home: SplashScreen(titulo),
    );
  }
}

Widget SplashScreen(String texto) {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
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
