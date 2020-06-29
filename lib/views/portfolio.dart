import 'package:flutter/material.dart';
import 'package:app/utils/theme.dart';
import '../models/asset.dart';

class PortfolioState extends State<Portfolio> {
  final _portfolio = <Asset>[
    Asset("Itaúsa", "ITSA4", "share"),
    Asset("Fleury", "FLRY3", "share"),
    Asset("Energias do Brasil", "ENBR3", "share"),
    Asset("Sinqia", "SQIA3", "share"),
    Asset("B3", "B3SA3", "share"),
    Asset("CSHG LOGÍSTICA FDO INV IMOB", "HGLG11", "reit"),
    Asset("XP LOG FDO INV IMOB", "XPLG11", "reit"),
    Asset("HSI MALL FDO INV IMOB", "HSML11", "reit"),
    Asset("KINEA RENDA IMOBILIÁRIA FDO INV IMOB", "KNRI11", "reit"),
    Asset("CSHG RENDA URBANA", "HGRU11", "reit"),
    Asset("IShare SP500CI", "IVVB11", "etf")
  ];

  @override
  Widget build(BuildContext context) {
    return  _buildPortfolio();
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
    for (asset in _portfolio){
      asset.refreshPrice();
    }
    return ListTile(
        title: Text(
          asset.name,
          style: biggerFont,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          asset.ticker,
          style: smallerFont,
        ),
        leading: Icon(asset.icon),
        trailing: Text(
          asset.price,
          style: normalFont,
        ));
  }
}

class Portfolio extends StatefulWidget {
  @override
  PortfolioState createState() => PortfolioState();
}
