import 'package:app/views/login.dart';
import 'package:app/views/home.dart';
import 'package:flutter/material.dart';

import 'package:app/views/splashScreen.dart';

void main() async{

  runApp(MaterialApp(
    title: "Bezunca",
    home: SplashScreen(),
    routes: <String, WidgetBuilder>{
      // Set routes for using the Navigator.
      '/home': (BuildContext context) => new Home(),
      '/login': (BuildContext context) => new Login()
    },
    )
  );
}