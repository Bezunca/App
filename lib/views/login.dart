import 'package:app/utils/theme.dart';

import 'package:app/utils/CEICredentials.dart';
import 'package:flutter/material.dart';

class LoginState extends State<Login> {

  final _cpf = TextEditingController();
  final _password = TextEditingController();

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
                decoration: InputDecoration(labelText: "CPF", labelStyle: normalFont)
              ),
              TextFormField(
                controller: _password,
                obscureText: true,
                keyboardType: TextInputType.text,
                style: normalFont,
                decoration: InputDecoration(labelText: "Senha", labelStyle: normalFont)
              ),
              Container(
                height: 40.0,
                margin: EdgeInsets.only(top: 30.0),
                child: RaisedButton(
                  color: Colors.blue,
                  child: Text("LOGIN", style: buttonFont),
                  onPressed: () { _onClickLogin(context); },
                ),
              )
            ],
          )
        )
      ),
    );
  }

  _onClickLogin(BuildContext context) async{
    CEICredentials creds = CEICredentials(_cpf.text, _password.text);
    creds.save();
    Navigator.of(context).pushReplacementNamed('/home');
  }
}

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}
