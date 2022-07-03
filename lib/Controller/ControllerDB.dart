import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/Custom/RememberMeController.dart';
import 'package:project/Model/Token/User.dart';
import 'package:project/Services/Token/AuthService.dart';

enum Login { SignIn, SignUp, Forgot, Payment, SignUpConfirm, PinCode }

class ControllerDB extends GetxController {
  AuthService _authService = AuthService();

  Rx<User> user = User().obs;

  RxString token = "".obs;
  RxBool isLoading = false.obs;
  Rx<Login> login = Login.SignIn.obs;

  updateLoginState(Login state) {
    login = state.obs;

    // isSignIn = state.obs;
    update();
  }

  Map<String, String> headers() {
    return <String, String>{
      "content-type": "application/json",
      "accept": "application/json",
      "Authorization": "Bearer " + token.value
    };
  }

  Future<String> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    var value = await _authService.register(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
    );
    return value;
  }

  Future signIn({
    required String mail,
    required String password,
  }) async {
    var value = await _authService.signIn(
      mail: mail,
      password: password,
    );
    user = value;
    update();
    print("usserrim = " + user.value.toString());
    if (user.value != null) {
      token = user.value.token!.obs;
      update();
      RememberMeControl.instance.setRemember("login", [mail, password]);
    }
    return user;
  }

  Future resetPassword({
    required String userName,
  }) async {
    var value = await _authService.resetPassword(
      userName: userName,
    );
    update();
    return value;
  }
}
