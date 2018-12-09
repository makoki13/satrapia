import 'package:flutter/material.dart';
import 'dart:ui';
//import 'package:splashscreen/splashscreen.dart';

import '../inicio/inicio.dart';
import 'login.dart';
import 'database_helper.dart';

import '../../api/routes.dart';

class HomeInicio extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<HomeInicio> {

  veteInicio(context) {
    Navigator.of(context).pushReplacementNamed("/inicio");
  }

  @override
  Widget build(BuildContext context) {
    //veteInicio(context);
    return new MaterialApp(
      title: 'Satrapia',
      home: SplashScreen(),
    );
  }
}

Widget SplashScreen() {
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
                  'xšaθrapIā',
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
