import 'package:flutter/material.dart';
import 'package:app/utils/theme.dart';
import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;

class ForgotPasswordState extends State<ForgotPassword> {

  final _email = TextEditingController();

  String _message = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Bezunca Investimentos"),
        ),
        body: Container(
          margin: EdgeInsets.all(30.0),
          child: ListView(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: Text("Esqueceu sua senha?",
                      style: biggerFont)),
              TextFormField(
                  controller: _email,
                  keyboardType: TextInputType.text,
                  style: normalFont,
                  decoration: InputDecoration(
                      labelText: "Email", labelStyle: normalFont)),
              Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: Text(_message,
                      style: smallErrorFont, textAlign: TextAlign.center)),
              Container(
                height: 40.0,
                margin: EdgeInsets.only(top: 20.0),
                child: RaisedButton(
                  color: Colors.blue,
                  child: Text("ENVIAR EMAIL", style: buttonFont),
                  onPressed: () {
                    _onClickForgotPassword(context);
                  },
                ),
              )
            ],
          ),
        ));
  }

  Future _onClickForgotPassword(BuildContext context) async {

    final http.Response response = await http.post(
      'http://104.197.141.112/user/forgot_password',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        'email':  _email.text
      })
    );

    developer.log('teste', name: 'forgot', error: jsonEncode(response.body));

    if (response.statusCode == 200) {
      setMessage("Cheque seu email");
    } else {
      var body = jsonDecode(response.body);
      setMessage(body['error']);
    }
  }

  void setMessage(message) {
    setState(() {
      _message = message;
    });
  }
}

class ForgotPassword extends StatefulWidget {
  @override
  ForgotPasswordState createState() => ForgotPasswordState();
}
