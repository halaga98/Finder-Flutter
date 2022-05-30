import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/PasswordPage.dart';
import 'package:project/Profile.dart';
import 'package:project/RegisterPage.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

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
          decoration: InputDecoration(
            hintText: "E-posta adresi",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: Icon(Icons.mail),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            hintText: "Parola",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: Icon(Icons.password),
          ),
          obscureText: true,
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () { Get.to(EditProfile());},
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
          Get.to(PasswordPage());
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
              Get.to(RegisterPage());
            },
            child: Text("Kayıt Ol"))
      ],
    );
  }
}
