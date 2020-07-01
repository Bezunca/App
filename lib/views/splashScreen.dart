import 'package:flutter/material.dart';

import "package:app/utils/appInitializer.dart";

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initApp(context);
    return Scaffold(body: Center(child: Text("Loading...")));
  }
}
