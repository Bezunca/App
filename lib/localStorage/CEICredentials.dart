import 'dart:convert';
import 'package:app/localStorage/storage.dart';

class CEICredentials {
  String _cpf;
  String _password;
  final String _filename = "cei_credentials.json";

  CEICredentials(this._cpf, this._password);

  CEICredentials.empty() {
    _cpf = "";
    _password = "";
  }

  @override
  String toString() {
    return "CPF: $_cpf";
  }

  fromJson(Map<String, dynamic> json) {
    _cpf = json['cpf'];
    _password = json['password'];
  }

  Map<String, dynamic> toJson() => {
        'cpf': _cpf,
        'password': _password,
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

  bool validateCredentials() {
    // Check if the CPF/password combo is registered in the CEI system
    return validateCPF(_cpf);
  }
}

bool validateCPF(String cpf) {
  RegExp exp = new RegExp(r"[0-9]{3}\.?[0-9]{3}\.?[0-9]{3}[\.-]?[0-9]{2}");
  RegExpMatch hasMatch = exp.firstMatch(cpf);
  return hasMatch != null && ((hasMatch.end - hasMatch.start) == cpf.length);
}
