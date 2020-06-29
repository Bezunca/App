import 'package:flutter/material.dart';
import 'package:app/local_storage/user_credentials.dart';

redirect(BuildContext context) async {

  UserCredentials creds = UserCredentials.empty();
  bool hasCredentials = await creds.exists();
  String route = hasCredentials ? "/home" : "/login";
  Navigator.of(context).pushReplacementNamed(route);

  /*WidgetsBinding.instance.addPostFrameCallback((_) {
    
  });*/
}
