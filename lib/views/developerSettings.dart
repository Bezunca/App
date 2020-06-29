import 'package:app/localStorage/CEICredentials.dart';
import 'package:app/localStorage/UserCredentials.dart';
import 'package:app/utils/checkPrices.dart';
import 'package:flutter/material.dart';

class DeveloperSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Developer Settings'),
      ),
      body: ListView(
        children: ListTile.divideTiles(context: context, tiles: [
          ListTile(
            title: Text("Erase User credentials from local storage"),
            onTap: () => {UserCredentials.empty().delete()},
          ),
          ListTile(
            title: Text("Erase CEI credentials from local storage"),
            onTap: () => {CEICredentials.empty().delete()},
          ),
          ListTile(
            title: Text("Test function 1"),
            onTap: test1,
          ),
          ListTile(
            title: Text("Test function 2"),
          )
        ]).toList(),
      ),
    );
  }
}

test1() async {
  print("test button pressed");
  print(await checkAssetPrice("ITSA4"));
  print("test ended");
}
