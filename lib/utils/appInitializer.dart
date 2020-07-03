import 'package:flutter/material.dart';

import "package:app/locator.dart";
import 'package:app/localStorage/userCredentials.dart';
import "package:app/services/dynamicLinkService.dart";

initApp(BuildContext context) async {

  final DynamicLinkService _dynamicLinkService = getIt<DynamicLinkService>(); 

  await _dynamicLinkService.handleDynamicLinks();

  redirect(context);

  /*WidgetsBinding.instance.addPostFrameCallback((_) {
    
  });*/
}

redirect(BuildContext context) async {
  UserCredentials creds = UserCredentials.empty();
  bool hasCredentials = await creds.exists();
  String route = hasCredentials ? "/home" : "/login";
  Navigator.of(context).pushReplacementNamed(route);
}
