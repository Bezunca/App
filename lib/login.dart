import 'package:flutter/material.dart';

class LoginState extends State<Login> {
  
  // Fonts
  final _normalFont = const TextStyle(fontSize: 18.0);

  final _buttonFont = const TextStyle(fontSize: 18.0, color: Colors.white);

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
                style: _normalFont,
                decoration: InputDecoration(labelText: "CPF", labelStyle: _normalFont)
              ),
              TextFormField(
                controller: _password,
                obscureText: true,
                keyboardType: TextInputType.text,
                style: _normalFont,
                decoration: InputDecoration(labelText: "Senha", labelStyle: _normalFont)
              ),
              Container(
                height: 40.0,
                margin: EdgeInsets.only(top: 30.0),
                child: RaisedButton(
                  color: Colors.blue,
                  child: Text("LOGIN", style: _buttonFont),
                  onPressed: () { _onClickLogin(context); },
                ),
              )
            ],
          )
        )
      ),
    );
  }

  _onClickLogin(BuildContext context) {
   
    
  }
}

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}
