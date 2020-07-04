import 'package:flutter/material.dart';

import 'package:app/utils/theme.dart';
import 'package:app/locator.dart';
import 'package:app/services/userApi.dart';
import 'package:app/utils/commonWidgets.dart';
import 'package:app/views/unlogged/login.dart';

class ResetPasswordState extends State<ResetPassword> {

  final UserApi _userApi = getIt<UserApi>();

  final _password = TextEditingController();
  String _message = "";

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
          )),
    );
  }

  Future _onClickResetPassword(BuildContext context, token) async {

    openDialog(context, null, Text("Redefinindo..."), [], dismissible: false);
    var response = await _userApi.resetPassword(_password.text, token);
    Navigator.of(context).pop();

    setState(() {
      if(response == null){
        setMessage("Erro no servidor.");
      }else if(response.containsKey('error')){
        setMessage(response['error']);
      }else{
        cleanScreen();
        openDialog(context, 
          Text("Senha redefinida!"), 
          Text("Já é possível fazer login com a nova senha!"), 
          [{'text': 'ok', 'action': () => { Navigator.of(context).pushReplacementNamed(Login.route) }}]
        );
      }
    });
  }

  void cleanScreen() {
    setState(() {
      _message = "";
      _password.clear();
    });
  }

  void setMessage(message) {
    setState(() {
      _message = message;
    });
  }
}

class ResetPassword extends StatefulWidget {

  static final String route = '/reset_password';

  @override
  ResetPasswordState createState() => ResetPasswordState();
}
