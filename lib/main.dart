import 'package:app/views/auth/login.dart';
import 'package:app/views/auth/register.dart';
import 'package:app/views/auth/forgot_password.dart';
import 'package:app/views/auth/reset_password.dart';
import 'package:app/views/user/ceiCredentials.dart';
import 'package:app/views/home.dart';
import 'package:app/views/user/profile.dart';
import 'package:flutter/material.dart';

import 'package:app/views/splashScreen.dart';
import 'package:app/locator.dart';
import 'package:app/services/navigationService.dart';

import 'package:app/routes.dart';

void main() async{

  setupLocator();

  runApp(MaterialApp(
    title: "Bezunca",
    home: SplashScreen(),
    routes: <String, WidgetBuilder>{
      // Set routes for using the Navigator.
      Routes.home: (BuildContext context) => new Home(),
      Routes.register: (BuildContext context) => new Register(),
      Routes.login: (BuildContext context) => new Login(),
      Routes.forgotPassword: (BuildContext context) => new ForgotPassword(),
      Routes.resetPassword: (BuildContext context) => new ResetPassword(),
      Routes.cei: (BuildContext context) => new CEI(),
      Routes.profile: (BuildContext context) => new UserProfile()
    },
    navigatorKey: getIt<NavigationService>().navigationKey,
    )
  );
}