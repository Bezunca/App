import 'package:flutter/material.dart';
import 'package:app/utils/theme.dart';
import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;

import 'package:app/localStorage/userCredentials.dart';

class LoginState extends State<Login> {
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
              child: TextFormField(
                  controller: _email,
                  keyboardType: TextInputType.text,
                  style: normalFont,
                  decoration: InputDecoration(
                      labelText: "Email", labelStyle: normalFont))),
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
              margin: EdgeInsets.only(top: 20.0),
              child: Text(_message,
                  style: smallErrorFont, textAlign: TextAlign.center)),
          Container(
              margin: EdgeInsets.only(left: 30, right: 30),
              child: FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/forgot_password');
                  },
                  child: Text("Esqueceu sua senha?",
                      style: smallerFont, textAlign: TextAlign.center))),
          Container(
            height: 40.0,
            margin: EdgeInsets.only(top: 0.0, left: 30, right: 30),
            child: RaisedButton(
              color: Colors.blue,
              child: Text("LOGIN", style: buttonFont),
              onPressed: () {
                _onClickLogin(context);
              },
            ),
          ),
          Container(
            height: 40.0,
            margin: EdgeInsets.only(top: 30.0, left: 30, right: 30),
            child: RaisedButton(
              color: Colors.blue,
              child: Text("CADASTRE-SE", style: buttonFont),
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
            ),
          ),
        ],
      ),
    );
  }

  Future _onClickLogin(BuildContext context) async {
    String email = _email.text;
    String password = _password.text;
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$email:$password'));

    developer.log('teste', name: 'login', error: jsonEncode(basicAuth));

    final http.Response response = await http.post(
      'http://104.197.141.112/user/login',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': basicAuth
      },
    );

    var body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      setMessage("");

      var token = body['token'];
      UserCredentials creds = UserCredentials(token);
      creds.save();
      Navigator.of(context).pushReplacementNamed('/home');
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

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}
