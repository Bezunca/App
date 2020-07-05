import 'package:app/views/auth/login.dart';
import 'package:app/views/auth/register.dart';
import 'package:app/views/auth/forgot_password.dart';
import 'package:app/views/auth/reset_password.dart';
import 'package:app/views/wallet/cei.dart';
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
      ResetPassword.route: (BuildContext context) => new ResetPassword(),
      CEI.route: (BuildContext context) => new CEI()
    },
    navigatorKey: getIt<NavigationService>().navigationKey,
    )
  );
}