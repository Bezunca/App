import 'package:flutter/material.dart';

import 'package:app/views/portfolio.dart';
import 'package:app/views/dividends.dart';
import 'package:app/views/developerSettings.dart';
import 'package:app/views/wallet/cei.dart';
import 'package:app/locator.dart';
import 'package:app/services/userApi.dart';

class HomeState extends State<Home> {

  final UserApi _userApi = getIt<UserApi>();

  int _currentIndex = 0;
  final List<Widget> _children = [Portfolio(), Dividends()];

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getUserInfo(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bezunca Investimentos'), actions: <Widget>[
        IconButton(icon: Icon(Icons.adb), onPressed: developerMenu)
      ]),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.account_balance_wallet),
            title: new Text('Portfolio'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.attach_money),
            title: new Text('Proventos'),
          )
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void developerMenu() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return DeveloperSettings();
        },
      ),
    );
  }

  void getUserInfo(context) async {
    var response = await _userApi.userInfo();
    if (response != null && !response.containsKey('errors')) {
      if(!response['cei']){
        Navigator.pushNamed(context, CEI.route);
      }
    }
  }
}

class Home extends StatefulWidget {

  static final String route = '/home';

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}
