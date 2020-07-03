import 'dart:developer' as developer;
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import "package:app/services/navigationService.dart";
import "package:app/locator.dart";
import 'package:app/localStorage/userCredentials.dart';

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
    developer.log('link', name: 'deeplink', error: deepLink);
    if (deepLink != null) {
      var route = deepLink.pathSegments[0];

      if (route == 'confirm_registration'){
        var token = deepLink.queryParameters['token'];
        _confirmRegistration(token);
      }else if(route == 'reset_password'){
        var token = deepLink.queryParameters['token'];
        _resetPassword(token);
      }
    }
  }

  void _confirmRegistration(String token) async{
    developer.log('token', name: 'deeplink', error: token);

    final http.Response response = await http.post(
      'http://104.197.141.112/user/confirm_registration',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        'token': token
      })
    );

    var body = jsonDecode(response.body);

    developer.log('body', name: 'deeplink', error: jsonEncode(body));

    if (response.statusCode == 200) {
      var authToken = body['token'];
      UserCredentials creds = UserCredentials(authToken);
      creds.save();
      _navigationService.setRoot('/home');
    } else {
      developer.log('error', name: 'deeplink', error: body['error']);
    }
  }

  void _resetPassword(String token) {
    developer.log('2', name: 'deeplink', error: token);
    _navigationService.push('/reset_password', arguments: {'token': token});
  }
}