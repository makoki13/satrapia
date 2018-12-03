import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'home_page_body.dart';

class HomeInicio extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<HomeInicio> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 3,
      navigateAfterSeconds: new AfterSplash(),
      title: new Text('xšaθrapā',
        style: new TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 36.0,
            color: Colors.red
        ),),

      image: new Image.network('https://flutter.io/images/catalog-widget-placeholder.png'),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      onClick: ()=>print("Flutter Egypt"),
      loaderColor: Colors.red,
    );
  }
}
