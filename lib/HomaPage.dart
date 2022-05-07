import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/Themes.dart';

import 'ListEvent.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.changeTheme(
              Get.isDarkMode ? Themes().lightTheme : Themes().darkTheme);
        },
      ),
      appBar: AppBar(
        title: Text(
          "Finder",
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            height: 250,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              image: DecorationImage(
                  image: AssetImage("assets/images/HomePage.png"),
                  fit: BoxFit.fitHeight),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          CarouselSlider.builder(
            itemCount: 15,
            options: CarouselOptions(
              height: 200,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: false,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) =>
                    Container(
              height: 200,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      image: DecorationImage(
                          image: AssetImage("assets/images/kayıtOl.jpg"),
                          fit: BoxFit.fitWidth),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "27 Apr - 13:00 ",
                    style: TextStyle(color: Colors.amber),
                  ),
                  Flexible(
                    child: Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has",
                      style: TextStyle(fontWeight: FontWeight.w700),
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text("İstanbul/Beykoz"),
                  Expanded(
                    child: ListView.builder(
                        itemCount: 4,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i) {
                          return Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.amber),
                          );
                        }),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      height: 50,
                      width: Get.width,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Yakındakiler",
                              style: TextStyle(color: Colors.black)),
                          Container(
                              height: 35,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(30)),
                              child: TextButton(
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                ),
                                onPressed: () {
                                  Get.to(EventPage());
                                },
                                child: Text('Keşfet'),
                              )),
                        ],
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 6,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(

                          height: 200,
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.red,
                                width: 5,
                              )
                          ),
                          child: Column(

                            children: [
                              Container(

                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),

                                  image: DecorationImage(
                                      image: AssetImage("assets/images/kayıtOl.jpg"),
                                      fit: BoxFit.fitWidth,

                                  ),

                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(

                                "27 Apr - 13:00 ",
                                style: TextStyle(color: Colors.amber),
                              ),
                              Flexible(
                                child: Text(
                                  "Maltepe Sahil Etkinlik",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text("İstanbul/Beykoz"),
                            ],
                          ),
                        );
                      }),
                ],
              ))
        ],
      ),
    );
  }
}
