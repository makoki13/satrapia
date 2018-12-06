import 'package:flutter/material.dart';

import 'configuracionHome.dart';

class Configuracion extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: ConfiguracionHome(),
      );
  }
}

