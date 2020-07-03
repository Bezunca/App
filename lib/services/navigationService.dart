import 'package:flutter/material.dart';

class NavigationService {

  final GlobalKey<NavigatorState> navigationKey = new GlobalKey<NavigatorState>();

  pop() {
    return navigationKey.currentState.pop();
  }

  Future<dynamic> push(String routeName, {dynamic arguments}) {
    return navigationKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> setRoot(String routeName, {dynamic arguments}) {
    return navigationKey.currentState.pushReplacementNamed(routeName, arguments: arguments);
  }
}
