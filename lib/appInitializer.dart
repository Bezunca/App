import 'package:flutter/material.dart';
import 'package:app/CEICredentials.dart';

redirect(BuildContext context) async{
  print("REDIRECT");
  CEICredentials creds = CEICredentials.empty();
  bool hasCredentials = await creds.exists();
  print("CONTENT: $hasCredentials");
  if (hasCredentials){
    Navigator.of(context).pushReplacementNamed('/home');
  }
  else{
    Navigator.of(context).pushReplacementNamed('/login');
  }

}