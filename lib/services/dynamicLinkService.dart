import 'dart:developer' as developer;
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import "package:app/services/navigationService.dart";
import "package:app/locator.dart";

import 'package:app/routes.dart';

class DynamicLinkService {
  final NavigationService _navigationService = getIt<NavigationService>();

  Future handleDynamicLinks() async {
    // 1. Get the initial dynamic link if the app is opened with a dynamic link
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();

    // 2. handle link that has been retrieved
    _handleDeepLink(data);

    // 3. Register a link callback to fire if the app is opened up from the background
    // using a dynamic link.
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      // 3a. handle link that has been retrieved
      _handleDeepLink(dynamicLink);
    }, onError: (OnLinkErrorException e) async {
      developer.log('Error', name: 'deeplink', error: e.message);
    });
  }

  void _handleDeepLink(PendingDynamicLinkData data) {
    final Uri deepLink = data?.link;
    if (deepLink != null) {
      var route = deepLink.pathSegments[0];

      if (route == 'confirm_registration') {
        var token = deepLink.queryParameters['token'];
        _confirmRegistration(token);
      } else if (route == 'reset_password') {
        var token = deepLink.queryParameters['token'];
        _resetPassword(token);
      }
    }
  }

  void _confirmRegistration(String token) async {
    _navigationService.setRoot(Routes.login, arguments: {'token': token});
  }

  void _resetPassword(String token) {
    _navigationService.setRoot(Routes.login);
    _navigationService.push(Routes.resetPassword, arguments: {'token': token});
  }
}
