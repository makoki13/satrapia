import 'package:flutter/material.dart';
import '../registro/registro.dart';
import 'login_screen.dart';

final routes = {
  '/login':         (BuildContext context) => new LoginScreen(),
  '/registro':         (BuildContext context) => new Registro(),
  '/' :          (BuildContext context) => new LoginScreen(),
};