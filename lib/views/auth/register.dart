import 'package:flutter/material.dart';

import 'package:app/utils/theme.dart';
import 'package:app/locator.dart';
import 'package:app/services/userApi.dart';
import 'package:app/utils/commonWidgets.dart';

class RegisterState extends State<Register> {
  final UserApi _userApi = getIt<UserApi>();

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _passwordConfirmation = TextEditingController();

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
                  child: Text("Cadastre-se!", style: biggerFont)),
              Container(
                  margin: EdgeInsets.only(top: 30, left: 30, right: 30),
                  child: TextFormField(
                      controller: _name,
                      keyboardType: TextInputType.text,
                      style: normalFont,
                      decoration: InputDecoration(
                          labelText: "Nome", labelStyle: normalFont))),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30),
                child: buildErrorMessage(_errors, 'name'),
              ),
              Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  child: TextFormField(
                      controller: _email,
                      keyboardType: TextInputType.text,
                      style: normalFont,
                      decoration: InputDecoration(
                          labelText: "Email", labelStyle: normalFont))),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30),
                child: buildErrorMessage(_errors, 'email'),
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
                  child: TextFormField(
                      controller: _passwordConfirmation,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      style: normalFont,
                      decoration: InputDecoration(
                          labelText: "Confirmar senha",
                          labelStyle: normalFont))),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30),
                child: buildErrorMessage(_errors, 'confirmation'),
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
                    _onClickRegister(context);
                  },
                ),
              )
            ],
          ),
        ));
  }

  Future _onClickRegister(BuildContext context) async {
    if (_password.text == _passwordConfirmation.text) {
      openDialog(context, null, Text("Enviando..."), [], dismissible: false);
      var response =
          await _userApi.register(_name.text, _email.text, _password.text);
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
              Text("Conta cadastrada!"),
              Text(
                  "Verifique sua caixa de entrada para ter acesso ao email de confirmação de conta!"),
              [
                {
                  'text': 'OK',
                  'action': () =>
                  {Navigator.of(context).popUntil((route) => route.isFirst)}
                }
              ]);
        }
      });
    } else {
      setState(() {
        _errors = {
          "confirmation": "A senha e sua confirmação devem ser iguais"
        };
      });
    }
  }

  void cleanScreen() {
    setState(() {
      _errors = {};
      _name.clear();
      _email.clear();
      _password.clear();
      _passwordConfirmation.clear();
    });
  }
}

class Register extends StatefulWidget {

  @override
  RegisterState createState() => RegisterState();
}
