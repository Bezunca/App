class Asset {
  final String _fantasyName;
  final String _ticker;
  final String currency;
  int _price; // Multiplied by 100

  Asset(this._fantasyName, this._ticker, this._price, {this.currency="R\$"});

  String get price => "$currency${(_price/100.0).toStringAsFixed(2)}";
  String get ticker => _ticker;
  String get name => _fantasyName;
}