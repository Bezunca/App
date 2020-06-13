import 'package:flutter/material.dart';
import 'package:app/utils/theme.dart';

import '../models/dividend.dart';

class DividendsState extends State<Dividends> {

  final _provisioned = <Dividend>[
    Dividend("Energias do Brasil", "ENBR3", "share", "28/06/2020", "31,30"),
    Dividend("KINEA RENDA IMOBILIÁRIA FDO INV IMOB", "KNRI11", "reit", "20/06/2020", "25,10"),
    Dividend("Sinqia", "SQIA3", "share", "17/06/2020", "08,60")
  ];

  final _credited = <Dividend>[
    Dividend("Itaúsa", "ITSA4", "share", "10/06/2020", "10,20"),
    Dividend("Fleury", "FLRY3", "share", "08/06/2020", "4,20"),
    Dividend("B3", "B3SA3", "share", "02/06/2020", "15,50"),
    Dividend("HSI MALL FDO INV IMOB", "HSML11", "reit", "01/06/2020", "20,60")
  ];

  @override
  Widget build(BuildContext context) {
    return _buildDividends();
  }

  Widget _buildDividends() {
    return ListView.builder(
        padding: const EdgeInsets.all(15),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
          int index = i ~/ 2;

          if (index == 0) return _buildTitle("Provisionado");
          index -= 1;

          if (index < _provisioned.length) return _buildRow(_provisioned[index]);
          index -= _provisioned.length;

          if (index == 0) return _buildTitle("Creditado");
          index -= 1;

          if (index < _credited.length) return _buildRow(_credited[index]);

          return null;
        });
  }

  Widget _buildTitle(text) {
    return ListTile(
      title: Text(
        text,
        style: biggerFont
      )  
    );
  }

  Widget _buildRow(Dividend dividend) {
    return ListTile(
      title: Text(
        dividend.name,
        style: biggerFont,
      ),
      subtitle: Text(
        dividend.date,
        style: smallerFont,
      ),
      leading: Icon(dividend.icon),
      trailing: Text(
        dividend.income,
        style: normalFont,
      )
    );
  }
}

class Dividends extends StatefulWidget {
  @override
  DividendsState createState() => DividendsState();
}
