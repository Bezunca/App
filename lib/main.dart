import 'package:flutter/material.dart';
import 'asset.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Bezunca",
      home: Portfolio(),
    );
  }
}

class PortfolioState extends State<Portfolio> {
  final _portfolio = <Asset>[
    Asset("Itaúsa", "ITSA4", 886),
    Asset("Fleury", "FLRY3", 2335),
    Asset("Energias do Brasil", "ENBR3", 1767),
    Asset("Sinqia", "SQIA3", 1961),
    Asset("B3", "B3SA3", 4530),
  ];

  // Fonts
  final _biggerFont =
      const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);
  final _normalFont = const TextStyle(fontSize: 18.0);
  final _smallerFont = const TextStyle(fontSize: 14.0, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bezunca Investimentos"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () => {}),
        ],
      ),
      body: _buildPortfolio(),
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
    return ListTile(
        title: Text(
          asset.name,
          style: _biggerFont,
        ),
        subtitle: Text(
          asset.ticker,
          style: _smallerFont,
        ),
        leading: Icon(Icons.equalizer),
        trailing: Text(
          asset.price,
          style: _normalFont,
        ));
  }
}

class Portfolio extends StatefulWidget {
  @override
  PortfolioState createState() => PortfolioState();
}
