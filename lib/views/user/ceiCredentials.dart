import 'package:flutter/material.dart';

import 'package:app/utils/theme.dart';
import 'package:app/locator.dart';
import 'package:app/services/userApi.dart';
import 'package:app/utils/commonWidgets.dart';

class CEIState extends State<CEI> {

  final UserApi _userApi = getIt<UserApi>();

  final _user = TextEditingController();
  final _password = TextEditingController();

  Map<String, dynamic> _errors = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Bezunca Investimentos"),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: ListView(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 30, left: 30, right: 30),
                  child: Text("Integração com CEI", style: biggerFont)),
              Container(
                  margin: EdgeInsets.only(top: 30, left: 30, right: 30),
                  child: TextFormField(
                      controller: _user,
                      keyboardType: TextInputType.text,
                      style: normalFont,
                      decoration: InputDecoration(
                          labelText: "CPF", labelStyle: normalFont))),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30),
                child: buildErrorMessage(_errors, 'user'),
              ),
              Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  child: TextFormField(
                      controller: _password,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      style: normalFont,
                      decoration: InputDecoration(
                          labelText: "Senha", labelStyle: normalFont))),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30),
                child: buildErrorMessage(_errors, 'password'),
              ),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30),
                child: buildErrorMessage(_errors, 'general'),
              ),
              Container(
                height: 40.0,
                margin: EdgeInsets.only(top: 20.0, left: 30, right: 30),
                child: RaisedButton(
                  color: Colors.blue,
                  child: Text("ENVIAR", style: buttonFont),
                  onPressed: () {
                    _onClickCEISync(context);
                  },
                ),
              )
            ],
          ),
        ));
  }

  Future _onClickCEISync(BuildContext context) async {
    openDialog(context, null, Text("Enviando..."), [], dismissible: false);
    var response = await _userApi.ceiCredentials(_user.text, _password.text);
    Navigator.of(context).pop();

    setState(() {
      if (response == null) {
        _errors = {"general": "Erro no servidor"};
      } else if (response.containsKey('errors')) {
        _errors = response["errors"];
      } else {
        cleanScreen();
        openDialog(
            context,
            Text("Integração realizada!"),
            Text(
                "Suas informações do CEI estarão disponíveis para visualização em breve!"),
            [
              {
                'text': 'OK',
                'action': () =>
                {Navigator.of(context).popUntil((route) => route.isFirst)}
              }
            ]);
      }
    });
  }

  void cleanScreen() {
    setState(() {
      _errors = {};
      _user.clear();
      _password.clear();
    });
  }
}

class CEI extends StatefulWidget {

  @override
  CEIState createState() => CEIState();
}
