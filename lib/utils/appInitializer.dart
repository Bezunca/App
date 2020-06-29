import 'package:flutter/material.dart';
import 'package:app/utils/CEICredentials.dart';

redirect(BuildContext context) async {
  CEICredentials creds = CEICredentials.empty();
  bool hasCredentials = await creds.exists();
  String route = hasCredentials ? "/home" : "/login";
  Navigator.of(context).pushReplacementNamed(route);
}
