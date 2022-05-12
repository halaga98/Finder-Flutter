import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/Themes.dart';

class DetailEvent extends StatefulWidget {
  const DetailEvent({Key? key}) : super(key: key);

  @override
  State<DetailEvent> createState() => _DetailEventState();
}

class _DetailEventState extends State<DetailEvent> {
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
