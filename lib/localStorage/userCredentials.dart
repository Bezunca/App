import 'dart:convert';
import 'package:app/localStorage/storage.dart';

class UserCredentials {

  String _token;
  final String _filename = "user_credentials.json";

  UserCredentials(this._token);

  UserCredentials.empty() {
    _token = "";
  }

  fromJson(Map<String, dynamic> json) {
    _token = json['token'];
  }

  Map<String, dynamic> toJson() => {
    'token': _token
  };

  save({bool safe_save = false}) {
    if (!safe_save) {
      Storage credStorage = Storage(_filename);
      credStorage.write(jsonEncode(this.toJson()));
    } else {
      print("Not implemented yet.");
    }
  }

  load() async {
    Storage credStorage = Storage(_filename);
    Map<String, dynamic> credJson = jsonDecode(await credStorage.read());
    this.fromJson(credJson);
  }

  exists() async {
    Storage credStorage = Storage(_filename);
    return await credStorage.exists();
  }

  delete() async {
    Storage credStorage = Storage(_filename);
    return await credStorage.delete();
  }

  String getToken() {
    return _token;
  }
}
