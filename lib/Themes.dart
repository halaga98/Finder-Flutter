import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Themes {
  final lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.blueGrey[300], secondaryHeaderColor: Colors.black,
    textSelectionColor: Colors.white,
    scaffoldBackgroundColor: Color(0xFFF0F7F7),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.amber,
      centerTitle: true,
      textTheme: TextTheme(
        headline1: TextStyle(color: Colors.black),
      ),
      titleTextStyle: TextStyle(color: Colors.white),
    ),
    buttonColor: Colors.amber,
    bottomAppBarColor: Color(0xff7F33FF), //bottom bar ıcon rengi
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(5.0)),
        primary: Colors.amber,
        textStyle: TextStyle(color: Colors.white),
      ),
    ),
  );
  final darkTheme = ThemeData.dark().copyWith(
      primaryColor: Colors.blueGrey[800],
      secondaryHeaderColor: Colors.white,
      textSelectionColor: Colors.black,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.amber,
        centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.black),
        textTheme: TextTheme(
          headline1: TextStyle(color: Colors.black),
        ),
      ),
      buttonColor: Colors.white,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0)),
          primary: Colors.amber,
          textStyle: TextStyle(color: Colors.black),
        ),
      ),
      bottomAppBarColor: Colors.black, //bottom bar ıcon rengi,
      inputDecorationTheme: InputDecorationTheme(fillColor: Colors.black12));
}
