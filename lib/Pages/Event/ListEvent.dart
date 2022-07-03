import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project/Model/Event/GetEventAll.dart';

import 'DetailEvent.dart';

class EventPage extends StatefulWidget {
  final GetEventAll events;
  const EventPage({Key? key, required this.events}) : super(key: key);

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
                            itemCount: widget.events.getEvent!.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              GetEvent data = widget.events.getEvent![index];
                              return GestureDetector(
                                onTap: () {
                                  Get.to(() => DetailEvent(
                                        evetnGuid: widget
                                            .events.getEvent![index].guidId!,
                                        enevtId:
                                            widget.events.getEvent![index].id!,
                                      ));
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
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(() => DetailEvent(
                                                evetnGuid: data.guidId!,
                                                enevtId: data.id!,
                                              ));
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
                                                      DateFormat.yMMMMd('tr')
                                                          .add_jm()
                                                          .format(DateTime
                                                              .parse(data
                                                                  .eventDate!)),
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
                                                        data.title!,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                        overflow:
                                                            TextOverflow.clip,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(data.address!),
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
                                                          image: NetworkImage(
                                                              data.image!),
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
