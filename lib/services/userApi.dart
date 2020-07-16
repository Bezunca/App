import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class UserApi {

  static const String baseURL = 'https://api.stockboard.com.br/';

  var userInfoData;

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
    var response = await request('GET', 'auth/info', {});
    if (response != null && !response.containsKey('errors')) {
      userInfoData = response;
      if (userInfoData != null && userInfoData['cei'] != null) {
        userInfoData['cei']['status_icon'] = _getWalletStatusIcon(userInfoData['cei']['status_type']);
        userInfoData['cei']['status_formatted_date'] = _formatDate(userInfoData['cei']['status_date']);
      }
    }
    return response;
  }

  _formatDate(dateTimeStr) {
    var dateTimeArr = dateTimeStr.split('T');
    var date = dateTimeArr[0];
    var time = dateTimeArr[1];
    var dateArr = date.split("-");
    var timeArr = time.split(":");
    return dateArr[2] + "/" + dateArr[1] + "/" + dateArr[0] + " " + timeArr[0] + ":" + timeArr[1];
  }

  _getWalletStatusIcon(walletStatus) {
    if (walletStatus == 1) {
      return Icon(Icons.access_time, color: Colors.yellow);
    } else if (walletStatus == 2) {
      return Icon(Icons.assignment_late, color: Colors.red);
    } else if (walletStatus == 3) {
      return Icon(Icons.sync_problem, color: Colors.red);
    } else {
      return Icon(Icons.sync, color: Colors.green);
    }
  }

  Future<Map<String, dynamic>> ceiCredentials(user, password) async {
    Map<String, dynamic> params = {
      'user': user,
      'password': password,
    };
    return request('POST', 'wallet/cei_credentials', params);
  }

  Future<Map<String, dynamic>> ceiSync() async {
    return request('GET', 'wallet/cei_sync', {});
  }
}
