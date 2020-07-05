import 'package:flutter/material.dart';

class NavigationService {

  final GlobalKey<NavigatorState> navigationKey = new GlobalKey<NavigatorState>();

  pop() {
    return navigationKey.currentState.pop();
  }

  push(String routeName, {dynamic arguments}) {
    return navigationKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  setRoot(String routeName, {dynamic arguments}) {
    navigationKey.currentState.popUntil((route) => route.isFirst);
    navigationKey.currentState.pushReplacementNamed(routeName, arguments: arguments);
  }
}
