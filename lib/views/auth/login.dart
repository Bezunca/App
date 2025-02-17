import 'package:flutter/material.dart';
import 'package:app/utils/theme.dart';

import 'package:app/localStorage/userCredentials.dart';
import 'package:app/locator.dart';
import 'package:app/services/userApi.dart';
import 'package:app/utils/commonWidgets.dart';

import 'package:app/routes.dart';

class LoginState extends State<Login> {
  
  final UserApi _userApi = getIt<UserApi>();

  final _email = TextEditingController();
  final _password = TextEditingController();

  Map<String, dynamic> _errors = {};

  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => confirmRegister(context));
  }

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
                  margin: EdgeInsets.only(left: 30, right: 30),
                  child: TextFormField(
                      controller: _password,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      style: normalFont,
                      decoration: InputDecoration(
                          labelText: "Senha", labelStyle: normalFont))),
              Container(
                margin: EdgeInsets.only(left:30,right:30),
                child: buildErrorMessage(_errors, 'password'),
              ),
              Container(
                margin: EdgeInsets.only(left:30,right:30),
                child: buildErrorMessage(_errors, 'general'),
              ),
              Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  child: FlatButton(
                      onPressed: () {
                        cleanScreen();
                        Navigator.pushNamed(context, Routes.forgotPassword);
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
                    cleanScreen();
                    Navigator.pushNamed(context, Routes.register);
                  },
                ),
              ),
            ],
          ),
        ));
  }

  Future _onClickLogin(BuildContext context) async {
    openDialog(context, null, Text("Logando..."), [], dismissible: false);
    var response = await _userApi.login(_email.text, _password.text);
    Navigator.of(context).pop();

    setState(() {
      if (response == null) {
        _errors = {"general": "Erro no servidor"};
      } else if (response.containsKey('errors')) {
        _errors = response['errors'];
      } else if (response.containsKey("token")){
        cleanScreen();
        var token = response['token'];
        doLogin(context, token);
      } else {
        _errors = {"general": "Erro no servidor"};
      }
    });
  }

  void doLogin(BuildContext context, token) {
    UserCredentials creds = UserCredentials(token);
    creds.save();
    _userApi.setAuthorizationToken(token);
    Navigator.of(context).pushReplacementNamed(Routes.home);
  }

  Future<void> confirmRegister(BuildContext context) async {
    var args = ModalRoute.of(context).settings.arguments as Map;
    if (args != null) {

      var token = args['token'];
      openDialog(context, null, Text("Ativando conta..."), [], dismissible: false);
      var response = await _userApi.confirmRegistration(token);
      Navigator.of(context).pop();

      setState(() {
        if (response == null) {
          openDialog(context, null, Text("Erro no servidor."), [
            {
              'text': 'OK',
              'action': () => {Navigator.of(context).pop()}
            }
          ]);
        } else if (response.containsKey('error')) {
          openDialog(context, Text("Erro"), Text(response['error']), [
            {
              'text': 'OK',
              'action': () => {Navigator.of(context).pop()}
            }
          ]);
        } else {
          cleanScreen();
          var authToken = response['token'];
          doLogin(context, authToken);
        }
      });
    }
  }

  void cleanScreen() {
    setState(() {
      _errors = {};
      _email.clear();
      _password.clear();
    });
  }

}

class Login extends StatefulWidget {

  @override
  LoginState createState() => LoginState();
}
