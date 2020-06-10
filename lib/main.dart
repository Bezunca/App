import 'package:app/login.dart';
import 'package:app/portfolio.dart';
import 'package:flutter/material.dart';

import 'splashScreen.dart';

void main() async{

  runApp(MaterialApp(
    title: "Bezunca",
    home: SplashScreen(),
    routes: <String, WidgetBuilder>{
      // Set routes for using the Navigator.
      '/home': (BuildContext context) => new Portfolio(),
      '/login': (BuildContext context) => new Login()
    },
    )
  );
}