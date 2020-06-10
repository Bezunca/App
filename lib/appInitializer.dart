import 'package:flutter/material.dart';
import 'package:app/CEICredentials.dart';

redirect(BuildContext context) async{
  CEICredentials creds = CEICredentials.empty();
  bool hasCredentials = await creds.exists();
  if (hasCredentials){
    Navigator.of(context).pushReplacementNamed('/home');
  }
  else{
    Navigator.of(context).pushReplacementNamed('/login');
  }

}