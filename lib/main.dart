import 'package:flutter/material.dart';
import 'asset.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Bezunca Investimentos",
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: RandomWords(),
    );
  }
}

class RandomWordsState extends State<RandomWords> {
  final _portfolio = <Asset>[
    Asset("Itaúsa", "ITSA4", 886),
    Asset("Fleury", "FLRY3", 2335),
    Asset("Energias BR", "ENBR3", 1767),
    Asset("Sinqia", "SQIA3", 1961),
    Asset("B3", "B3SA3", 4530),
  ];
  final Set<Asset> _saved = Set<Asset>();

  // Fonts
  final _biggerFont =
      const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w900);
  final _normalFont = const TextStyle(fontSize: 18.0);
  final _smallerFont = const TextStyle(fontSize: 14.0, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bezunca Investimentos"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildPortfolio(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // Add 20 lines from here...
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
            (Asset asset) {
              return ListTile(
                title: Text(
                  asset.name,
                  style: _biggerFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  Widget _buildPortfolio() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
          int index = i ~/ 2;
          if (index < _portfolio.length) return _buildRow(_portfolio[index]);
          return null;
        });
  }

  Widget _buildRow(Asset asset) {
    final bool alreadySaved = _saved.contains(asset);
    return ListTile(
      title: Text(
        asset.name,
        style: _biggerFont,
      ),
      subtitle: Text(
        asset.ticker,
        style: _smallerFont,
      ),
      leading: Icon(
        Icons.euro_symbol,
        color: alreadySaved ? Colors.green : null,
      ),
      trailing: Text(
        asset.price,
        style: _normalFont,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(asset);
          } else {
            _saved.add(asset);
          }
        });
      },
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}
