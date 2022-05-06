import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CEventPage extends StatefulWidget {
  const CEventPage({Key? key}) : super(key: key);

  @override
  State<CEventPage> createState() => _CEventPageState();
}
class _CEventPageState extends State<CEventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text(
        "Finder",
        style: TextStyle(fontSize: 30),
          ),
        ),
    );
  }
}
