import 'package:flutter/material.dart';

class Dividend {
  final String _fantasyName;
  final String _ticker;
  final String _type;
  final String _date;
  final String currency;
  final int _netIncome;

  final Map<String, IconData> _assetTypeIcons = {
    "share": Icons.library_books,
    "reit": Icons.location_city
  };

  Dividend(
      this._fantasyName, this._ticker, this._type, this._date, this._netIncome,
      {this.currency = "R\$"});

  String get name => _fantasyName;
  String get ticker => _ticker;
  IconData get icon => _assetTypeIcons[this._type];
  String get date => _date;
  String get income => "$currency${(_netIncome/100.0).toStringAsFixed(2)}";
}
