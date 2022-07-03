import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyCircular extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
      ) // Image.asset("assets/Video/loading.gif",width: 50,height: 50,),
          ),
    );
  }
}
