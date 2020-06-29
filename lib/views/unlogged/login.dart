import 'package:flutter/material.dart';
import 'package:app/utils/theme.dart';
import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;

import 'package:app/localStorage/UserCredentials.dart';

class LoginState extends State<Login> {
  final _email = TextEditingController();
  final _password = TextEditingController();

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
                      controller: _email,
                      keyboardType: TextInputType.text,
                      style: normalFont,
                      decoration: InputDecoration(
                          labelText: "Email", labelStyle: normalFont)),
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
                          style: smallErrorFont, textAlign: TextAlign.center)),
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

  Future<bool> _onClickLogin(BuildContext context) async {

    String email = _email.text;
    String password = _password.text;
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$email:$password'));

    final http.Response response = await http.post(
      'http://104.197.141.112/user/login',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': basicAuth
      },
    );

    var body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      var token = body['token'];
      
      UserCredentials creds = UserCredentials(token);
      setState(() {
        warningMessage = "";
      });
      creds.save();
      Navigator.of(context).pushReplacementNamed('/home');

    } else {
      var error = body['error'];
      setState(() {
        warningMessage = error;
      });
    }

    return true;
  }
}

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}
