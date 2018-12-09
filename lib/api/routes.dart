import 'package:flutter/material.dart';
import '../screens/registro/registro.dart';
import '../screens/partida/partida.dart';
import '../screens/tutorial/tutorial.dart';
import '../screens/configuracion/configuracion.dart';
import '../screens/inicio/inicio.dart';
//import 'login_screen.dart';

final routes = {
  //'/login':          (BuildContext context) => LoginScreen(),
  '/registro':       (BuildContext context) => Registro(),
  '/inicio' :          (BuildContext context) => Inicio(),
  '/partida':        (BuildContext context) => PartidaApp(),
  '/tutorial':       (BuildContext context) => Tutorial(),
  '/configuracion':  (BuildContext context) => Configuracion(),
};