import 'package:flutter/material.dart';

import 'package:app/utils/theme.dart';
import 'package:app/locator.dart';
import 'package:app/services/userApi.dart';
import 'package:app/utils/commonWidgets.dart';
import 'package:app/views/unlogged/login.dart';

class ForgotPasswordState extends State<ForgotPassword> {

  final UserApi _userApi = getIt<UserApi>();

  final _email = TextEditingController();
  String _message = "";

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
                  child: Text("Esqueceu sua senha?", style: biggerFont)),
              Container(
                  margin: EdgeInsets.only(top: 30, left: 30, right: 30),
                  child: TextFormField(
                      controller: _email,
                      keyboardType: TextInputType.text,
                      style: normalFont,
                      decoration: InputDecoration(
                          labelText: "Email", labelStyle: normalFont))),
              Container(
                  margin: EdgeInsets.only(top: 20.0, left: 30, right: 30),
                  child: Text(_message,
                      style: smallErrorFont, textAlign: TextAlign.center)),
              Container(
                height: 40.0,
                margin: EdgeInsets.only(top: 20.0, left: 30, right: 30),
                child: RaisedButton(
                  color: Colors.blue,
                  child: Text("ENVIAR EMAIL", style: buttonFont),
                  onPressed: () {
                    _onClickForgotPassword(context);
                  },
                ),
              )
            ],
          )),
    );
  }

  Future _onClickForgotPassword(BuildContext context) async {

    openDialog(context, null, Text("Enviando Email..."), [], dismissible: false);
    var response = await _userApi.forgotPassword( _email.text);
    Navigator.of(context).pop();

    setState(() {
      if(response == null){
        setMessage("Erro no servidor.");
      }else if(response.containsKey('error')){
        setMessage(response['error']);
      }else{
        openDialog(context, 
          Text("Email enviado!"), 
          Text("Verifique sua caixa de entrada para ter acesso as instruções de redefinição de senha!"), 
          [{'text': 'ok', 'action': () => { Navigator.of(context).pushReplacementNamed(Login.route) }}]
        );
        cleanScreen();
      }
    });
  }

  void cleanScreen() {
    setState(() {
      _message = "";
      _email.clear();
    });
  }

  void setMessage(message) {
    setState(() {
      _message = message;
    });
  }
}

class ForgotPassword extends StatefulWidget {

  static final String route = '/forgot_password';

  @override
  ForgotPasswordState createState() => ForgotPasswordState();
}
