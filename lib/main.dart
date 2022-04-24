import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/Bottom.dart';
import 'package:project/Themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Finder',
      theme: Themes().lightTheme,
      darkTheme: Themes().darkTheme,
      home: Bottom(),
    );
  }
}
