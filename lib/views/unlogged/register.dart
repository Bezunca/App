import 'package:flutter/material.dart';
import 'package:app/utils/theme.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterState extends State<Register> {

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  String _message = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Bezunca Investimentos"),
        ),
        body: ListView(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 30, left: 30, right: 30),
                  child: Text("Cadastre-se!",
                      style: biggerFont)),
              Container(
                margin: EdgeInsets.only(top: 30, left: 30, right: 30),
                child: TextFormField(
                  controller: _name,
                  keyboardType: TextInputType.text,
                  style: normalFont,
                  decoration: InputDecoration(
                      labelText: "Nome", labelStyle: normalFont))
              ),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30),
                child: TextFormField(
                  controller: _email,
                  keyboardType: TextInputType.text,
                  style: normalFont,
                  decoration: InputDecoration(
                      labelText: "Email", labelStyle: normalFont))
              ),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30),
                child: TextFormField(
                  controller: _password,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  style: normalFont,
                  decoration: InputDecoration(
                      labelText: "Senha", labelStyle: normalFont))
              ),
              Container(
                  margin: EdgeInsets.only(top: 20.0, left: 30, right: 30),
                  child: Text(_message,
                      style: smallErrorFont, textAlign: TextAlign.center)),
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
        );
  }

  Future _onClickRegister(BuildContext context) async {
    
    final http.Response response = await http.post(
      'http://104.197.141.112/user/register',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        'name': _name.text,
        'email':  _email.text,
        'password': _password.text
      })
    );

    var body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      setMessage("Cheque seu email");
    } else {
      setMessage(body['error']);
    }
  }

  void setMessage(message) {
    setState(() {
      _message = message;
    });
  }
}

class Register extends StatefulWidget {
  @override
  RegisterState createState() => RegisterState();
}
