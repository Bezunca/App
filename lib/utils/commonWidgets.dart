import 'package:app/utils/theme.dart';
import 'package:flutter/material.dart';

void openDialog(context, title, content, actions, {dismissible=true} ) {

  var dialogActions;
  if (actions.length > 0){
    dialogActions = <Widget>[];
    for( var i = 0 ; i < actions.length; i++ ) { 
      dialogActions.add(
        FlatButton(
          child: Text(actions[i]['text']),
          onPressed: actions[i]['action'],
        )
      );
    } 
  }

  showDialog(
    context: context,
    barrierDismissible: dismissible,
    builder: (BuildContext context) {
      return AlertDialog(
        title: title,
        content: content,
        actions: dialogActions,
      );
    }
  );
}

Widget buildErrorMessage(errors, key) {
  if (errors.containsKey(key)) {
    return Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Text(errors[key],
            style: smallErrorFont, textAlign: TextAlign.center));
  }else{
    return Container();
  }
}