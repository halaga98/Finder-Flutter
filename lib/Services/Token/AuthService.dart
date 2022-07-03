import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:project/Model/Token/User.dart';
import 'package:project/Services/ServiceUrl.dart';
import 'package:get/get.dart';

class AuthService {
  final Map<String, String> headers = {
    "content-type": "application/json",
    "accept": "application/json",
  };

  final ServiceUrl _serviceUrl = ServiceUrl();

  AuthService();

  Future signIn({required String mail, required String password}) async {
    log("reqq url = " + _serviceUrl.login);

    var postValue = {
      "userName": mail,
      "password": password,
    };

    var response = await http.post(Uri.parse(_serviceUrl.login),
        headers: headers, body: jsonEncode(postValue));
    log("signIn req" + postValue.toString());
    log("signIn res" + response.body);
    var responseData;
    try {
      responseData = jsonDecode(response.body) as Map<String, dynamic>;
      User user = User.fromJson(responseData);
      return user.obs;
    } catch (e, stacktrace) {
      Get.showSnackbar(GetSnackBar(
        message: response.body.replaceAll("\"", ""),
        duration: Duration(seconds: 1),
      ));
      print("sign in hata = " + e.toString());
      print('Stacktrace: ' + stacktrace.toString());
      return responseData;
    }
  }

  Future register(
      {required String email,
      required String firstName,
      required String lastName,
      required String password}) async {
    log("reqq url = " + _serviceUrl.register);
    var postValue = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "password": password,
    };
    var response = await http.post(Uri.parse(_serviceUrl.register),
        headers: headers, body: jsonEncode(postValue));
    log("register req" + postValue.toString());
    log("register res" + response.body);
    return response.body;
  }

  Future resetPassword({required String userName}) async {
    log("reqq url = " + _serviceUrl.resetPassword);
    var postValue = {"userName": userName};
    var response = await http.post(Uri.parse(_serviceUrl.resetPassword),
        headers: headers, body: jsonEncode(postValue));
    log("resetPassword req" + postValue.toString());
    log("resetPassword res" + response.body);
    return response.body;
  }
}
