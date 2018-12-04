import 'package:flutter/material.dart';

import 'routes.dart';
import 'login_screen.dart';
import 'database_helper.dart';

class Login extends StatelessWidget {
  var db = new DatabaseHelper();
  bool modoTest = true;

  @override
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (modoTest==true) db.deleteUsers();
    return new MaterialApp(
      title: 'My Login App',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      routes: routes,
      home: LoginScreen(),
    );
  }
}