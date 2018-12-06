import 'dart:ui';

import 'package:flutter/material.dart';
import '../home/database_helper.dart';
import '../home/user.dart';
import '../home/routes.dart';
import '../partida/partida.dart';

class Inicio extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new InicioState();
  }
}

class InicioState extends State<Inicio> {
  BuildContext _ctx;

  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  String _username, _password;

  InicioState() {

  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    var nuevaPartidaBtn = new MaterialButton(
      height: 40.0,
      minWidth: 200.0,
      color:  Colors.primaries[0],
      textColor: Colors.white,
      child: new Text("NUEVA PARTIDA"),
      onPressed: () {Navigator.of(_ctx).pushReplacementNamed("/partida");},
      splashColor: Colors.black,
    );

    var continuarPartidaBtn = new MaterialButton(
      height: 40.0,
      minWidth: 200.0,
      color:  Colors.primaries[0],
      textColor: Colors.white,
      child: new Text("CONTINUAR PARTIDA"),
      onPressed: () {Navigator.of(_ctx).pushReplacementNamed("/login");},
      splashColor: Colors.black,
    );

    var tutorialBtn = new MaterialButton(
      height: 40.0,
      minWidth: 200.0,
      color:  Colors.primaries[0],
      textColor: Colors.white,
      child: new Text("TUTORIAL"),
      onPressed: () {Navigator.of(_ctx).pushReplacementNamed("/tutorial");},
      splashColor: Colors.black,
    );

    var configuracionBtn = new MaterialButton(
      height: 40.0,
      minWidth: 200.0,
      color:  Colors.primaries[0],
      textColor: Colors.white,
      child: new Text("CONFIGURACIÓN"),
      onPressed: () {Navigator.of(_ctx).pushReplacementNamed("/configuracion");},
      splashColor: Colors.black,
    );

    var botonera = new Column(
      children: <Widget>[
        new Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: new Text(
            "SATRAPÍA",
            textScaleFactor: 2.0,
          ),
        ),
        Divider(
          height: 20.0,
          color: Colors.transparent,
        ),
        nuevaPartidaBtn,
        Divider(
          height: 20.0,
          color: Colors.transparent,
        ),
        continuarPartidaBtn,
        Divider(
          height: 20.0,
          color: Colors.transparent,
        ),
        tutorialBtn,
        Divider(
          height: 20.0,
          color: Colors.transparent,
        ),
        configuracionBtn,
      ],
      crossAxisAlignment: CrossAxisAlignment.center,
    );

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
                child: botonera,
                height: 330.0,
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

  _nuevaPartida(){
    print("Boton partida");
    Navigator.of(_ctx).pushReplacementNamed("/partida");
  }

  _continuarPartida() {
    Navigator.of(_ctx).pushReplacementNamed("/partida");
  }
}