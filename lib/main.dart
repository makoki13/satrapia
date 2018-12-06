import 'package:flutter/material.dart';

import 'package:satrapia/screens/home/home.dart';
import 'screens/home/routes.dart';

void main() {
  runApp(
    new MaterialApp(
      title: "Satrapia",
      routes: routes,
      home: new HomeInicio(),
    ),
  );
}