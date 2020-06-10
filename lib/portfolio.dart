import 'package:flutter/material.dart';
import 'asset.dart';

class PortfolioState extends State<Portfolio> {
  final _portfolio = <Asset>[
    Asset("Itaúsa", "ITSA4", 886, "share"),
    Asset("Fleury", "FLRY3", 2335, "share"),
    Asset("Energias do Brasil", "ENBR3", 1767, "share"),
    Asset("Sinqia", "SQIA3", 1961, "share"),
    Asset("B3", "B3SA3", 4530, "share"),
    Asset("CSHG LOGÍSTICA FDO INV IMOB", "HGLG11", 18195, "reit"),
    Asset("XP LOG FDO INV IMOB", "XPLG11", 11500, "reit"),
    Asset("HSI MALL FDO INV IMOB", "HSML11", 8320, "reit"),
    Asset("KINEA RENDA IMOBILIÁRIA FDO INV IMOB", "KNRI11", 17239, "reit"),
    Asset("CSHG RENDA URBANA", "HGRU11", 11597, "reit"),
    Asset("IShare SP500CI", "IVVB11", 11597, "etf")
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
        leading: Icon(asset.icon),
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
