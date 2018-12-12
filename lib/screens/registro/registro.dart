import 'dart:ui';

import 'package:flutter/material.dart';
import '../../clases/tools/usuario.dart';
import 'package:satrapia/api/routes.dart';
import '../../api/baseDeDatos2.dart';

class Registro extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new RegistroState();
  }
}

class RegistroState extends State<Registro> {
  BuildContext _ctx;

  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final myController = TextEditingController();

  String _username;

  void _submit() async {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() => _isLoading = true);

      String nombreUsuario = myController.text;
      Usuario usuario = Usuario(nombreUsuario,'mak0k1');

      print ("USUARIO: $nombreUsuario");

      DBProvider.db.saveUser(usuario).then( (result) {
        print("guardado $nombreUsuario. Redirigiendo");
        Navigator.pushNamedAndRemoveUntil(context, '/inicio', (_) => false);
      });
    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    var loginBtn = new RaisedButton(
      onPressed: _submit,
      child: new Text("CREAR USUARIO"),
      color: Colors.primaries[0],
    );
    var loginForm = new Column(
      children: <Widget>[
        new Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: new Text(
            "SATRAPÍA",
            textScaleFactor: 2.0,
          ),
        ),
        new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextFormField(
                  onSaved: (val) { print("OSTIAS: $val - $_username"); _username = val;},
                  validator: (val) {
                    return val.length < 3
                        ? "El usuario ha de tener al menos 3 letras"
                        : null;
                  },
                  controller: myController,
                  decoration: new InputDecoration(labelText: "Usuario"),
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 20.0,
          color: Colors.transparent,
        ),
        _isLoading ? new CircularProgressIndicator() : loginBtn,
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
                child: loginForm,
                height: 250.0,
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


  @override
  void onLoginError(String errorTxt) {
    _showSnackBar(errorTxt);
    setState(() => _isLoading = false);
  }

  @override
  void onLoginSuccess(Usuario user) async {
    _showSnackBar(user.toString());
    setState(() => _isLoading = false);
    print("onLoginSucces ${user}");
  }

}