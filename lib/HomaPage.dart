import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/DetailEvent.dart';
import 'package:project/ListEvent.dart';
import 'package:project/Themes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.changeTheme(
              Get.isDarkMode ? Themes().lightTheme : Themes().darkTheme);
        },
      ),*/
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
                    GestureDetector(
              onTap: () {
                Get.to(() => DetailEvent());
              },
              child: Container(
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
                    Text("İstanbul/Şişli"),
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
                                  shape: BoxShape.circle,
                                  color: Colors.amber,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/unknown.png"))),
                            );
                          }),
                    )
                  ],
                ),
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
                      height: 100,
                      width: Get.width,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            topLeft: Radius.circular(5)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Yakındakiler",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17)),
                          GestureDetector(
                            onTap: () {
                              Get.to(EventPage());
                            },
                            child: Container(
                              height: 35,
                              width: 110,
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey[900],
                                  borderRadius: BorderRadius.circular(30)),
                              child: Center(
                                  child: Text(
                                "Keşfet",
                                style: TextStyle(color: Colors.amber),
                              )),
                            ),
                          )
                        ],
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 6,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(() => DetailEvent());
                              },
                              child: Container(
                                height: 100,
                                width: Get.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(5),
                                      topLeft: Radius.circular(5)),
                                ),
                                margin: EdgeInsets.only(bottom: 5),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "27 Apr - 13:00 ",
                                            style: TextStyle(
                                                color: Colors.amber,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Flexible(
                                            child: Text(
                                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700),
                                              overflow: TextOverflow.clip,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text("İstanbul/Şişli"),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          height: 80,
                                          width: 125,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                                image: AssetImage(index % 2 == 0
                                                    ? "assets/images/kayıtOl.jpg"
                                                    : "assets/images/etkinlik.jpg"),
                                                fit: BoxFit.fitWidth),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 1,
                            )
                          ],
                        );
                      }),
                ],
              ))
        ],
      ),
    );
  }
}
