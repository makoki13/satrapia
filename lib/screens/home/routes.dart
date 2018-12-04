import 'package:flutter/material.dart';
import '../registro/registro.dart';
import '../partida/partida.dart';
import 'login_screen.dart';

final routes = {
  '/login':         (BuildContext context) => LoginScreen(),
  '/registro':         (BuildContext context) => Registro(),
  '/home' :          (BuildContext context) => LoginScreen(),
  '/partida':         (BuildContext context) => PartidaApp(),
};