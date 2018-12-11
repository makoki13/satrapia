import 'package:flutter/material.dart';
import '../../api/baseDeDatos.dart';

class TutorialHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new TutorialState();
  }
}

class TutorialState extends State<TutorialHome> {
  @override
  void initState() {
    salvaTutorial();
  }

  salvaTutorial() async {
    Widget _widget;

    BaseDeDatos db = new BaseDeDatos();
    await db.initDb();

    await db.saveTutorial();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Pantalla de tutorial"),
        automaticallyImplyLeading: false,
      ),
      body: new Center(
        child: new Text("Succeeded!",
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0
          ),),

      ),
    );
  }
}