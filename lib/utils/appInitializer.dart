import 'package:flutter/material.dart';
import 'package:app/localStorage/UserCredentials.dart';

redirect(BuildContext context) async {

  UserCredentials creds = UserCredentials.empty();
  bool hasCredentials = await creds.exists();
  String route = hasCredentials ? "/home" : "/login";
  Navigator.of(context).pushReplacementNamed(route);

  /*WidgetsBinding.instance.addPostFrameCallback((_) {
    
  });*/
}
