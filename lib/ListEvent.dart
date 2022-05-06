
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/Themes.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

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


          Container(
              margin: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
              child: Column(
                children: [

                  Container(

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      )),
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
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width,

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
                        );


                      }),
                ],
              ))
        ],
      ),
    );
  }
}
