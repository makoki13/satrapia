import 'package:flutter/material.dart';

import 'package:satrapia/api/routes.dart';
import 'login_screen.dart';

class Login extends StatelessWidget {
  @override
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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