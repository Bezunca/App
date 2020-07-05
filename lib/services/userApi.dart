import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class UserApi {

  static const String baseURL = 'http://104.197.141.112/';

  static Map<String, String> _headers = {
    'Authorization': "",
    'Content-Type': 'application/json',
  };

  void setAuthorizationToken(String token) {
    _headers['Authorization'] = token;
  }
  
  Future<Map<String, dynamic>> request(String method, String endpoint, [Map<String, dynamic> params]) async {

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

    return request('POST', 'auth/login', {});
  }

  Future<Map<String, dynamic>> register(name, email, password) async {
    Map<String, dynamic> params = {
      'name': name,
      'email': email,
      'password': password,
    };
    return request('POST', 'auth/register', params);
  }

  Future<Map<String, dynamic>> forgotPassword(email) async {
    Map<String, dynamic> params = {
      'email': email
    };
    return request('POST', 'auth/forgot_password', params);
  }

  Future<Map<String, dynamic>> resetPassword(password, token) async {
    Map<String, dynamic> params = {
      'password': password,
      'token': token
    };
    return request('POST', 'auth/reset_password', params);
  }

  Future<Map<String, dynamic>> confirmRegistration(token) async {
    Map<String, dynamic> params = {
      'token': token
    };
    return request('POST', 'auth/confirm_registration', params);
  }

  Future<Map<String, dynamic>> userInfo() async {
    return request('GET', 'auth/info', {});
  }

  Future<Map<String, dynamic>> ceiSync(user, password) async {
    Map<String, dynamic> params = {
      'user': user,
      'password': password,
    };
    return request('POST', 'wallet/cei_sync', params);
  }
}
