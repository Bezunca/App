import 'package:flutter/material.dart';
import 'package:app/utils/theme.dart';

import 'package:app/localStorage/userCredentials.dart';
import 'package:app/locator.dart';
import 'package:app/services/userApi.dart';
import 'package:app/utils/commonWidgets.dart';
import 'package:app/views/unlogged/register.dart';
import 'package:app/views/unlogged/forgot_password.dart';
import 'package:app/views/home.dart';

class LoginState extends State<Login> {
  final UserApi _userApi = getIt<UserApi>();

  final _email = TextEditingController();
  final _password = TextEditingController();

  String _message = "";

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
                        cleanScreen();
                        Navigator.pushNamed(context, ForgotPassword.route);
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
                    Navigator.pushNamed(context, Register.route);
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
        setMessage("Erro no servidor.");
      } else if (response.containsKey('error')) {
        setMessage(response['error']);
      } else {
        cleanScreen();
        var token = response['token'];
        doLogin(context, token);
      }
    });
  }

  void doLogin(BuildContext context, token) {
    UserCredentials creds = UserCredentials(token);
    creds.save();
    Navigator.of(context).pushReplacementNamed(Home.route);
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
              'text': 'ok',
              'action': () => {Navigator.of(context).pop()}
            }
          ]);
        } else if (response.containsKey('error')) {
          openDialog(context, Text("Erro"), Text(response['error']), [
            {
              'text': 'ok',
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
      _message = "";
      _email.clear();
      _password.clear();
    });
  }

  void setMessage(message) {
    setState(() {
      _message = message;
    });
  }
}

class Login extends StatefulWidget {
  static final String route = '/login';

  @override
  LoginState createState() => LoginState();
}
