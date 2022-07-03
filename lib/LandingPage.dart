import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project/BottomBar/Bottom.dart';
import 'package:project/Custom/MyCircular.dart';
import 'package:project/Custom/RememberMeController.dart';
import 'package:project/Pages/Login/LoginPage.dart';
import 'package:project/Pages/Login/PasswordPage.dart';
import 'package:project/Pages/Login/RegisterPage.dart';

import 'Controller/ControllerDB.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  ControllerDB c = Get.put(ControllerDB());
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      List<String>? temp =
          await RememberMeControl.instance.getRemember("login");
      if (temp != null) {
        print("temp nin içindyiz ");
        await c
            .signIn(
          mail: temp[0],
          password: temp[1],
        )
            .then((value) {
          if (value != null) {
            print("Hatalı Kayıt" + value.toString());
          }
        });
      }

      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ControllerDB());
    print(c.login.value);
    return GetBuilder<ControllerDB>(builder: (c) {
      return isLoading
          ? MyCircular()
          : c.user.value.id == null
              ? c.login.value == Login.SignIn
                  ? LoginPage() //SignInPage()
                  : c.login.value == Login.Forgot
                      ? PasswordPage()
                      : RegisterPage()
              : Bottom();
    });
  }
}
