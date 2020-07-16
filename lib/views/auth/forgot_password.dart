import 'package:flutter/material.dart';

import 'package:app/utils/theme.dart';
import 'package:app/locator.dart';
import 'package:app/services/userApi.dart';
import 'package:app/utils/commonWidgets.dart';

class ForgotPasswordState extends State<ForgotPassword> {

  final UserApi _userApi = getIt<UserApi>();

  final _email = TextEditingController();
  Map<String, dynamic> _errors = {};

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
                margin: EdgeInsets.only(left:30,right:30),
                child: buildErrorMessage(_errors, 'email'),
              ),
              Container(
                margin: EdgeInsets.only(left:30,right:30),
                child: buildErrorMessage(_errors, 'general'),
              ),
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
        _errors = {"general": "Erro no servidor"};
      }else if(response.containsKey('errors')){
        _errors = response["errors"];
      }else{
        openDialog(context, 
          Text("Email enviado!"), 
          Text("Verifique sua caixa de entrada para ter acesso as instruções de redefinição de senha!"), 
          [{'text': 'OK', 'action': () => { Navigator.of(context).popUntil((route) => route.isFirst) }}]
        );
        cleanScreen();
      }
    });
  }

  void cleanScreen() {
    setState(() {
      _errors = {};
      _email.clear();
    });
  }

}

class ForgotPassword extends StatefulWidget {

  @override
  ForgotPasswordState createState() => ForgotPasswordState();
}
