import 'package:flutter/material.dart';

import 'package:app/utils/theme.dart';
import 'package:app/locator.dart';
import 'package:app/services/userApi.dart';
import 'package:app/utils/commonWidgets.dart';
import 'package:app/views/unlogged/login.dart';

class ResetPasswordState extends State<ResetPassword> {
  final UserApi _userApi = getIt<UserApi>();

  final _password = TextEditingController();
  final _passwordConfirmation = TextEditingController();
  Map<String, dynamic> _errors = {};

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments as Map;

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
                  child: Text("Nova senha:", style: biggerFont)),
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
                margin: EdgeInsets.only(left:30,right:30),
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
                margin: EdgeInsets.only(left:30,right:30),
                child: buildErrorMessage(_errors, 'confirmation'),
              ),
              Container(
                height: 40.0,
                margin: EdgeInsets.only(top: 20.0, left: 30, right: 30),
                child: RaisedButton(
                  color: Colors.blue,
                  child: Text("REDEFINIR", style: buttonFont),
                  onPressed: () {
                    _onClickResetPassword(context, args['token']);
                  },
                ),
              )
            ],
          )),
    );
  }

  Future _onClickResetPassword(BuildContext context, token) async {
    if (_password.text == _passwordConfirmation.text) {
      openDialog(context, null, Text("Redefinindo..."), [], dismissible: false);
      var response = await _userApi.resetPassword(_password.text, token);
      Navigator.of(context).pop();

      setState(() {
        if (response == null) {
          _errors = {"general": "Erro no servidor"};
        } else if (response.containsKey('errors')) {
          _errors = response["errors"];
        } else {
          cleanScreen();
          openDialog(context, Text("Senha redefinida!"),
              Text("Já é possível fazer login com a nova senha!"), [
            {
              'text': 'ok',
              'action': () =>
                  {Navigator.of(context).pushReplacementNamed(Login.route)}
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
      _password.clear();
    });
  }
}

class ResetPassword extends StatefulWidget {
  static final String route = '/reset_password';

  @override
  ResetPasswordState createState() => ResetPasswordState();
}
