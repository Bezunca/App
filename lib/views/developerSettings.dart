import 'package:app/utils/CEICredentials.dart';
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
            title: Text("Erase CEI credentials from local storage"),
            onTap: () => {CEICredentials.empty().delete()},
          ),
          ListTile(
            title: Text("Option 2"),
          ),
          ListTile(
            title: Text("Option 3"),
          )
        ]).toList(),
      ),
    );
  }
}
