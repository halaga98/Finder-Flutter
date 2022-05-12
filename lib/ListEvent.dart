import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'DetailEvent.dart';

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
        centerTitle: false,
        title: Text(
          "Etkinlikler",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: Column(
                children: [
                  Container(
                      child: Column(
                    children: [
                      Container(
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 20,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.to(() => DetailEvent());
                                },
                                child: Container(
                                  height: 125,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(5),
                                        topLeft: Radius.circular(5)),
                                  ),
                                  margin: EdgeInsets.only(bottom: 5),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700),
                                                      overflow:
                                                          TextOverflow.clip,
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
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            "assets/images/kayıtOl.jpg"),
                                                        fit: BoxFit.fitWidth),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        thickness: 1,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      )
                    ],
                  ))
                ],
              ))
        ],
      ),
    );
  }
}
