import 'package:flutter/material.dart';
import 'package:app/utils/theme.dart';
import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;


class ResetPasswordState extends State<ResetPassword> {
  
  final _password = TextEditingController();
  String _message = "";

  @override
  Widget build(BuildContext context) {

    var args = ModalRoute.of(context).settings.arguments as Map;

    developer.log('token', name: 'reset', error: args['token']);

    return Scaffold(
      appBar: AppBar(
        title: Text("Bezunca Investimentos"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
                  margin: EdgeInsets.only(top: 30, left: 30, right: 30),
                  child: Text("Nova senha:",
                      style: biggerFont)),
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
      ),
    );
  }

  Future _onClickResetPassword(BuildContext context, token) async {

    developer.log('token inside', name: 'reset', error: token);

    final http.Response response = await http.post(
      'http://104.197.141.112/user/reset_password',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        'password': _password.text,
        'token': token
      })
    );

    var body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      setMessage("Senha redefinida!");
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

class ResetPassword extends StatefulWidget {
  @override
  ResetPasswordState createState() => ResetPasswordState();
}
