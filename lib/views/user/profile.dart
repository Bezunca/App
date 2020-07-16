import 'package:flutter/material.dart';

import 'package:app/locator.dart';
import 'package:app/services/userApi.dart';
import 'package:app/localStorage/userCredentials.dart';
import 'package:app/utils/commonWidgets.dart';

import 'package:app/routes.dart';

class UserProfileState extends State<UserProfile> {
  final UserApi _userApi = getIt<UserApi>();

  Map userProfileData;

  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _parseUserProfile());
  }

  @override
  Widget build(BuildContext context) {
    return _buildUserProfile(context);
  }

  _buildUserProfile(BuildContext context) {
    if (userProfileData != null) {
      return ListView(padding: EdgeInsets.all(20), children: <Widget>[
        ListTile(
          title: Text(userProfileData['name']),
          subtitle: Text(userProfileData['email']),
        ),
        _buildWalletRow(context, 'cei', 'CEI', Routes.cei, _userApi.ceiSync),
        ListTile(
          leading: Icon(Icons.subdirectory_arrow_left),
          title: Text("Sair"),
          onTap: _logOut,
        ),
      ]);
    } else {
      return Container();
    }
  }

  _buildWalletRow(BuildContext context, walletKey, walletName, walletRoute, syncFunc) {
    if (userProfileData[walletKey] != null) {
      return ListTile(
        onTap:() => _confirmSync(context, walletName, syncFunc),
        leading: userProfileData[walletKey]['status_icon'],
        title: Text(walletName),
        subtitle: Text(userProfileData[walletKey]['status_message'] +
            "\n" +
            userProfileData[walletKey]['status_formatted_date']),
        isThreeLine: true,
        trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.pushNamed(context, walletRoute).then((value) => {_updateUserProfile()});
            }),
      );
    } else {
      return ListTile(
          title: Text(walletName),
          trailing: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, walletRoute).then((value) => {_updateUserProfile()});
              }));
    }
  }

  _confirmSync(BuildContext context, walletName, syncFunc) {
    openDialog(
      context,
      Text("Sincronizar " + walletName),
      Text(
          "Deseja enviar uma solicitação de sincronização?"),
      [
        {
          'text': 'CANCELAR',
          'action': () => {Navigator.of(context).pop()}
        },
        {
          'text': 'OK',
          'action': () => {_doSync(syncFunc)}
        }
      ]);
  }

  _doSync(syncFunc) async {
    Navigator.of(context).pop();
    openDialog(context, null, Text("Enviando..."), [], dismissible: false);
    var response = await syncFunc();
    await _updateUserProfile();
    Navigator.of(context).pop();

    if (response == null) {
      openDialog(context,null, Text("Erro no servidor"),[{'text': 'OK','action': () => {Navigator.of(context).pop()}}]);
    } else if (response.containsKey('errors')) {
      if (response["errors"].containsKey('general')){
        openDialog(context,null, Text(response["errors"]['general']),[{'text': 'OK','action': () => {Navigator.of(context).pop()}}]);
      }else{
        openDialog(context,null, Text("Erro ao enviar solicitação"),[{'text': 'OK','action': () => {Navigator.of(context).pop()}}]);
      }
    } else {
      openDialog(
        context,
        Text("Solicitação enviada!"),
        Text(
            "Suas informações serão atualizadas em breve!"),
        [
          {
            'text': 'OK',
            'action': () =>
            {Navigator.of(context).pop()}
          }
        ]);
    }
  }

  _updateUserProfile() async {
    await _userApi.userInfo();
    _parseUserProfile();
  }

  _parseUserProfile() async {
    if (_userApi.userInfoData == null){
      await _userApi.userInfo();
    }
    setState(() {
      userProfileData = _userApi.userInfoData;
    });
  }

  _logOut() {
    UserCredentials.empty().delete();
    _userApi.setAuthorizationToken("");
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.of(context).pushReplacementNamed(Routes.login);
  }
}

class UserProfile extends StatefulWidget {
  @override
  UserProfileState createState() => UserProfileState();
}
