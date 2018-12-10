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

  //await db.saveUser(usuario);
  //await db.deleteUsers();

  runApp(
    new MaterialApp(
      title: "Satrapia",
      routes: routes,
      home: HomeInicio(),
    ),
  );
}