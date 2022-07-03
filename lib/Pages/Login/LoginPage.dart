import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/Controller/ControllerDB.dart';
import 'package:project/Pages/Login/PasswordPage.dart';
import 'package:project/Pages/Profile/Profile.dart';
import 'package:project/Pages/Login/RegisterPage.dart';

import '../Profile/DetailProfile.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _controllerMail = TextEditingController();
  TextEditingController _controllerPass = TextEditingController();
  ControllerDB _controllerDB = Get.put(ControllerDB());

  Future<void> login(String mail, String password) async {
    await _controllerDB.signIn(mail: mail, password: password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              _header(context),
              SizedBox(
                height: 30,
              ),
              _inputField(context),
              _forgotPassword(context),
              _signup(context),
            ],
          ),
        ),
      ),
    );
  }

  _header(context) {
    return Column(
      children: [
        Container(
          height: 250,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            image: DecorationImage(
                image: AssetImage("assets/images/loginPage.png"),
                fit: BoxFit.fitHeight),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Hoşgeldin",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Text("Giriş Yap ve Etkinlikleri Keşfet"),
      ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _controllerMail,
          decoration: InputDecoration(
            hintText: "E-posta adresi",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none),
            filled: true,
            prefixIcon: Icon(Icons.mail),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _controllerPass,
          decoration: InputDecoration(
            hintText: "Parola",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none),
            filled: true,
            prefixIcon: Icon(Icons.password),
          ),
          obscureText: true,
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async {
            await login(_controllerMail.text, _controllerPass.text);
          },
          child: Text(
            "Giriş Yap",
            style: TextStyle(),
          ),
        )
      ],
    );
  }

  _forgotPassword(context) {
    return TextButton(
        onPressed: () {
          _controllerDB.updateLoginState(Login.Forgot);
        },
        child: Text("Şifrenizi Unuttunuz mu?"));
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Hesabınız yok mu?"),
        TextButton(
            onPressed: () {
              _controllerDB.updateLoginState(Login.SignUp);
            },
            child: Text("Kayıt Ol"))
      ],
    );
  }
}
