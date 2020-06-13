import 'package:flutter/material.dart';
import "../utils/appInitializer.dart";

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    redirect(context);
    return Scaffold(body: Center(child: Text("Loading...")));
  }
}
