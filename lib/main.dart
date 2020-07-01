import 'package:app/views/unlogged/login.dart';
import 'package:app/views/unlogged/register.dart';
import 'package:app/views/unlogged/forgot_password.dart';
import 'package:app/views/home.dart';
import 'package:flutter/material.dart';

import 'package:app/views/splashScreen.dart';
import 'package:app/locator.dart';

void main() async{

  setupLocator();

  runApp(MaterialApp(
    title: "Bezunca",
    home: SplashScreen(),
    routes: <String, WidgetBuilder>{
      // Set routes for using the Navigator.
      '/home': (BuildContext context) => new Home(),
      '/register': (BuildContext context) => new Register(),
      '/login': (BuildContext context) => new Login(),
      '/forgot_password': (BuildContext context) => new ForgotPassword()
    },
    )
  );
}