import 'package:flutter/material.dart';
import "../utils/checkPrices.dart";

class Asset {
  final String _fantasyName;
  final String _ticker;
  final String currency;
  final String _type;
  int _price = 0; // Multiplied by 100

  final Map<String, IconData> _assetTypeIcons= {
    "share": Icons.library_books,
    "reit": Icons.location_city,
    "etf": Icons.equalizer,
  };

  Asset(this._fantasyName, this._ticker, this._type, {this.currency="R\$"});

  Asset.withPrice(this._fantasyName, this._ticker, this._type, this._price, {this.currency="R\$"});

  String get price => "$currency${(_price/100.0).toStringAsFixed(2)}";
  String get ticker => _ticker;
  String get name => _fantasyName;
  IconData get icon => _assetTypeIcons[this._type];

  refreshPrice() async {
    _price = await checkAssetPrice(_ticker);
  }
}