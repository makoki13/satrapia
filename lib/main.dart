import 'package:flutter/material.dart';

import 'package:satrapia/api/routes.dart';

import 'screens/inicio/inicio.dart';
import 'screens/registro/registro.dart';
import 'screens/home/home.dart';

import 'api/baseDeDatos.dart';
import 'clases/tools/usuario.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  Widget _widget;

  BaseDeDatos db = new BaseDeDatos();
  await db.initDb();

  Usuario usuario = Usuario('makoki','mak0k1');

  //await db.saveUser(usuario);
  //await db.deleteUsers();

  bool logeado = await db.isLoggedIn();
  logeado = false;
  print("Logeado $logeado");
  if (logeado == false)
    _widget = HomeInicio();
  else
    _widget = Inicio();
  runApp(
    new MaterialApp(
      title: "Satrapia",
      routes: routes,
      home: _widget,
    ),
  );
}