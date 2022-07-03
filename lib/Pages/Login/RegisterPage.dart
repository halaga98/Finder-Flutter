import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/BottomBar/Bottom.dart';
import 'package:project/Controller/ControllerDB.dart';
import 'package:project/Pages/Login/LoginPage.dart';

class RegisterPage extends StatelessWidget {
  ControllerDB _controllerDB = Get.put(ControllerDB());
  TextEditingController _controllername = TextEditingController();
  TextEditingController _controllersurename = TextEditingController();
  TextEditingController _controllermail = TextEditingController();
  TextEditingController _controllerpass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 35,
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      _controllerDB.updateLoginState(Login.SignIn);
                    },
                    child: Icon(Icons.arrow_back))
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _header(context),
                    SizedBox(height: 20),
                    _inputField(context),
                    _forgotPassword(context),
                    _signup(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _header(context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            image: DecorationImage(
                image: AssetImage("assets/images/RegisterPage.png"),
                fit: BoxFit.fitHeight),
          ),
        ),
        Text(
          "Hoşgeldin",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Text("Kayıt ol ve Etkinlikleri Keşfet"),
      ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _controllername,
          decoration: InputDecoration(
            hintText: "İsminiz",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none),
            filled: true,
            prefixIcon: Icon(Icons.person),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _controllersurename,
          decoration: InputDecoration(
            hintText: "Soyisminiz",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none),
            filled: true,
            prefixIcon: Icon(Icons.person),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _controllermail,
          decoration: InputDecoration(
            hintText: "E-Posta Adresiniz",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none),
            filled: true,
            prefixIcon: Icon(Icons.mail),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _controllerpass,
          decoration: InputDecoration(
            hintText: "Parola",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none),
            filled: true,
            prefixIcon: Icon(Icons.password_sharp),
          ),
          obscureText: true,
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async {
            await _controllerDB
                .register(
                    email: _controllermail.text,
                    password: _controllerpass.text,
                    firstName: _controllername.text.capitalizeFirst!,
                    lastName: _controllersurename.text.capitalizeFirst!)
                .then((value) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(value.replaceAll(" \" ", "")),
              ));
              if (value == "\"Kullanıcı başarıyla eklendi.\"") {
                _controllerDB.updateLoginState(Login.SignIn);
              }
            });
          },
          child: Text(
            "Kayıt Ol",
            style: TextStyle(fontSize: 20),
          ),
          style: ElevatedButton.styleFrom(
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(5.0)),
            primary: Colors.amber,
          ),
        )
      ],
    );
  }

  _forgotPassword(context) {
    return TextButton(
        onPressed: () {},
        child: Text(
          "Hesap oluşturarak, Gizlilik Politikası, Kullanım Koşulları ve Çerez Politikası "
          "kabul etmiş sayılırsınız.",
          textAlign: TextAlign.center,
        ));
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Hesabınız var mı?"),
        TextButton(
            onPressed: () {
              _controllerDB.updateLoginState(Login.SignIn);
            },
            child: Text("Giriş Yap"))
      ],
    );
  }
}
