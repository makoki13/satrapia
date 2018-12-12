import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:satrapia/api/routes.dart';
import '../partida/partida.dart';
import '../../api/baseDeDatos2.dart';

class Inicio extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new InicioState();
  }
}

class InicioState extends State<Inicio> {
  BuildContext _ctx;
  String _usuario;
  bool _isButtonNuevaPartidaDisabled = false;
  bool _isButtonContinuarPartidaDisabled = true;

  @override
  void initState() {
    _getUsuario().then((resultUsuario) {
      _hayPartidaNueva().then((result) {
        print("Resultado nueva Partida: $result");
        setState(() {
          _usuario = resultUsuario;
          _isButtonContinuarPartidaDisabled = !result;
        });
      });
    });
  }

  Future<String> _getUsuario() async {
    String usuario = await DBProvider.db.usuario();
    return usuario;
  }

  Future<bool> _hayPartidaNueva() async {
    bool _partidaNueva = await DBProvider.db.hayPartidaNueva();
    return _partidaNueva;
  }

  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  void _showSnackBar(String text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }

  nuevaPartida() {
    //onPressed: _isButtonDisabled ? null : _incrementCounter,
    print("Boton nuevaPartida");
    Navigator.of(_ctx).pushReplacementNamed("/partida");
  }

  continuarPartida() {
    print("Boton continuarPartida");
    Navigator.of(_ctx).pushReplacementNamed("/partida");
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;

    var txtUsuario = new Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: new Text(
        "Bienvenido, $_usuario",
        textScaleFactor: 1.3,
        style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Colors.white,
            shadows: [Shadow(color: Colors.black, offset: Offset(2.0, 1.0), blurRadius: 0.5)],  ),
      ),
    );

    var nuevaPartidaBtn = new MaterialButton(
      height: 40.0,
      minWidth: 200.0,
      color:  Colors.primaries[0],
      textColor: Colors.white,
      child: new Text("NUEVA PARTIDA"),
      onPressed: _isButtonNuevaPartidaDisabled ? null : nuevaPartida,
      splashColor: Colors.black,
    );

    var continuarPartidaBtn = new MaterialButton(
      height: 40.0,
      minWidth: 200.0,
      color:  Colors.primaries[0],
      textColor: Colors.white,
      child: new Text("CONTINUAR PARTIDA"),
      onPressed: _isButtonContinuarPartidaDisabled ? null : continuarPartida,
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
        txtUsuario,
        new Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: new Text(
            "SATRAPÍA",
            textScaleFactor: 2.0,
            style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Colors.grey,
              shadows: [Shadow(color: Colors.black, offset: Offset(2.0, 1.0), blurRadius: 0.5)],  ),
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
                height: 370.0,
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