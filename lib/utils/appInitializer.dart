import 'package:flutter/material.dart';

import "package:app/locator.dart";
import 'package:app/localStorage/userCredentials.dart';
import "package:app/services/dynamicLinkService.dart";
import "package:app/services/userApi.dart";

import "package:app/views/auth/login.dart";
import "package:app/views/home.dart";

initApp(BuildContext context) async {

  final DynamicLinkService _dynamicLinkService = getIt<DynamicLinkService>(); 
  await _dynamicLinkService.handleDynamicLinks();

  redirect(context);
}

redirect(BuildContext context) async {
  
  UserCredentials creds = UserCredentials.empty();
  bool hasCredentials = await creds.exists();

  if (hasCredentials) {
    await creds.load();
    String token = creds.getToken();

    final UserApi _userApi = getIt<UserApi>();
    _userApi.setAuthorizationToken(token);
  }

  String route = hasCredentials ? Home.route : Login.route;
  Navigator.of(context).pushReplacementNamed(route);
}
