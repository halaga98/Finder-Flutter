import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/Controller/ControllerDB.dart';
import 'package:project/Pages/Login/RegisterPage.dart';

class PasswordPage extends StatelessWidget {
  ControllerDB _controllerDB = Get.put(ControllerDB());
  TextEditingController _textEditingController = TextEditingController();

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
                height: 45,
              ),
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        _controllerDB.updateLoginState(Login.SignIn);
                      },
                      child: Icon(Icons.arrow_back))
                ],
              ),
              SizedBox(
                height: 15,
              ),
              _header(context),
              SizedBox(
                height: 30,
              ),
              _inputField(context),
            ],
          ),
        ),
      ),
    );
  }

  _header(context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          height: 250,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            image: DecorationImage(
                image: AssetImage("assets/images/password.png"),
                fit: BoxFit.fitHeight),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Parolamı Unuttum",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _textEditingController,
          decoration: InputDecoration(
            hintText: "E-posta adresin",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none),
            filled: true,
            prefixIcon: Icon(Icons.mail),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async {
            await _controllerDB
                .resetPassword(
              userName: _textEditingController.text,
            )
                .then((value) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(value.replaceAll(" \" ", " ")),
              ));
            });
            _controllerDB.updateLoginState(Login.SignIn);
          },
          child: Text(
            "Parolayı Sıfırla",
            style: TextStyle(),
          ),
        )
      ],
    );
  }
}
