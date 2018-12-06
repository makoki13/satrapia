import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../api/models.dart';
import '../../api/principal.dart';
import '../../api/api.dart';

import 'tutorialHome.dart';

class Tutorial extends StatelessWidget {

  Principal miPrincipal = Principal();
  ModeloPrincipal _modeloPrincipal = Principal.getModelo();

  @override
  Widget build(BuildContext context) {
    // At the top level of our app, we'll, create a ScopedModel Widget. This
    // will provide the CounterModel to all children in the app that request it
    // using a ScopedModelDescendant.
    return ScopedModel<ModeloPrincipal>(
      model: _modeloPrincipal,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: TutorialHome(),
      ),
    );
  }
}

