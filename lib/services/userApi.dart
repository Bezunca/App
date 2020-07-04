import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class UserApi {

  static const String baseURL = 'http://104.197.141.112/';

  String token;

  static Map<String, String> _headers = {
    'Authorization': "",
    'Content-Type': 'application/json',
  };

  void setAuthorizationToken(String token) {
    _headers['Authorization'] = token;
  }
  
  Future<Map<String, dynamic>> response(String method, String endpoint, [Map<String, dynamic> params]) async {
    method = method.toUpperCase();
    http.Response httpResponse;
    String fullUrl = baseURL + endpoint;
    try {
      if (method == 'POST') {
        httpResponse = await http.post(fullUrl, headers: _headers, body: json.encode(params));
      } else if (method == 'GET') {
        httpResponse = await http.get(fullUrl, headers: _headers);
      }
      if (httpResponse.statusCode >= 200 && httpResponse.statusCode < 500) {
        try {
          var body = json.decode(httpResponse.body);
          if (body == null){
            body = json.decode("{}");
          }
          return body;
        } on FormatException {
          return null;
        }
      }
      return null;
    } on HttpException {
      return null;
    }
  }

  Future<Map<String, dynamic>> login(email, password) async {

    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$email:$password'));
    setAuthorizationToken(basicAuth);

    return response('POST', 'user/login', {});
  }

  Future<Map<String, dynamic>> register(name, email, password) async {
    Map<String, dynamic> params = {
      'name': name,
      'email': email,
      'password': password,
    };
    return response('POST', 'user/register', params);
  }

  Future<Map<String, dynamic>> forgotPassword(email) async {
    Map<String, dynamic> params = {
      'email': email
    };
    return response('POST', 'user/forgot_password', params);
  }

  Future<Map<String, dynamic>> resetPassword(password, token) async {
    Map<String, dynamic> params = {
      'password': password,
      'token': token
    };
    return response('POST', 'user/reset_password', params);
  }

  Future<Map<String, dynamic>> confirmRegistration(token) async {
    Map<String, dynamic> params = {
      'token': token
    };
    return response('POST', 'user/confirm_registration', params);
  }
}
