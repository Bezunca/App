import 'package:app/utils/theme.dart';

import 'package:app/localStorage/CEICredentials.dart';
import 'package:flutter/material.dart';

class LoginState extends State<Login> {
  final _cpf = TextEditingController();
  final _password = TextEditingController();

  final _smallErrorFont =
      const TextStyle(fontSize: 14.0, color: Colors.redAccent);

  String warningMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bezunca Investimentos"),
      ),
      body: Form(
          child: Padding(
              padding: EdgeInsets.all(30),
              child: ListView(
                children: <Widget>[
                  TextFormField(
                      controller: _cpf,
                      keyboardType: TextInputType.text,
                      style: normalFont,
                      decoration: InputDecoration(
                          labelText: "CPF", labelStyle: normalFont)),
                  TextFormField(
                      controller: _password,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      style: normalFont,
                      decoration: InputDecoration(
                          labelText: "Senha", labelStyle: normalFont)),
                  Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: Text(warningMessage,
                          style: _smallErrorFont, textAlign: TextAlign.center)),
                  Container(
                    height: 40.0,
                    margin: EdgeInsets.only(top: 30.0),
                    child: RaisedButton(
                      color: Colors.blue,
                      child: Text("LOGIN", style: buttonFont),
                      onPressed: () {
                        _onClickLogin(context);
                      },
                    ),
                  )
                ],
              ))),
    );
  }

  _onClickLogin(BuildContext context) async {
    CEICredentials creds = CEICredentials(_cpf.text, _password.text);
    if (creds.validateCredentials()) {
      setState(() {
        warningMessage = "";
      });
      creds.save();
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      setState(() {
        warningMessage = "Credenciais inválidas";
      });
    }
  }
}

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}
