import 'package:app/views/unlogged/login.dart';
import 'package:app/views/unlogged/register.dart';
import 'package:app/views/unlogged/forgot_password.dart';
import 'package:app/views/unlogged/reset_password.dart';
import 'package:app/views/home.dart';
import 'package:flutter/material.dart';

import 'package:app/views/splashScreen.dart';
import 'package:app/locator.dart';
import 'package:app/services/navigationService.dart';

void main() async{

  setupLocator();

  runApp(MaterialApp(
    title: "Bezunca",
    home: SplashScreen(),
    routes: <String, WidgetBuilder>{
      // Set routes for using the Navigator.
      Home.route: (BuildContext context) => new Home(),
      Register.route: (BuildContext context) => new Register(),
      Login.route: (BuildContext context) => new Login(),
      ForgotPassword.route: (BuildContext context) => new ForgotPassword(),
      ResetPassword.route: (BuildContext context) => new ResetPassword()
    },
    navigatorKey: getIt<NavigationService>().navigationKey,
    )
  );
}