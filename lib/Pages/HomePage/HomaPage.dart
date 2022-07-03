import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project/Controller/ControllerDB.dart';
import 'package:project/Controller/ControllerEvent.dart';
import 'package:project/Custom/MyCircular.dart';
import 'package:project/Model/Event/GetEventAll.dart';
import 'package:project/Pages/Event/DetailEvent.dart';
import 'package:project/Pages/Event/ListEvent.dart';
import 'package:project/Themese/Themes.dart';
import 'package:intl/date_symbol_data_local.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ControllerEvent _controllerEvent = Get.put(ControllerEvent());
  ControllerDB _controllerDB = Get.put(ControllerDB());
  bool loading = true;
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      initializeDateFormatting();

      await _controllerEvent.GetAllEvent(_controllerDB.headers());
      setState(() {
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControllerEvent>(builder: (c) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Finder",
            style: TextStyle(fontSize: 30),
          ),
        ),
        body: loading
            ? MyCircular()
            : ListView(
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
                    itemCount:
                        _controllerEvent.AllEvents.value.getEvent!.length,
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
                    itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) =>
                        GestureDetector(
                      onTap: () {
                        Get.to(() => DetailEvent(
                              evetnGuid: _controllerEvent
                                  .AllEvents.value.getEvent![itemIndex].guidId!,
                              enevtId: _controllerEvent
                                  .AllEvents.value.getEvent![itemIndex].id!,
                            ));
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                image: DecorationImage(
                                    image: NetworkImage(_controllerEvent
                                        .AllEvents
                                        .value
                                        .getEvent![itemIndex]
                                        .image!),
                                    fit: BoxFit.fitWidth),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              DateFormat.yMMMMd('tr').add_jm().format(
                                  DateTime.parse(_controllerEvent.AllEvents
                                      .value.getEvent![itemIndex].eventDate!)),
                              style: TextStyle(color: Colors.amber),
                            ),
                            Flexible(
                              child: Text(
                                _controllerEvent.AllEvents.value
                                    .getEvent![itemIndex].title!,
                                style: TextStyle(fontWeight: FontWeight.w700),
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(_controllerEvent
                                .AllEvents.value.getEvent![itemIndex].address!),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: _controllerEvent.AllEvents.value
                                      .getEvent![itemIndex].users!.length,
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, i) {
                                    return Container(
                                      height: 25,
                                      width: 25,
                                      margin: EdgeInsets.only(right: 5),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.amber,
                                          image: DecorationImage(
                                              image: NetworkImage(_controllerEvent
                                                      .AllEvents
                                                      .value
                                                      .getEvent![itemIndex]
                                                      .users![i]
                                                      .userImage!
                                                      .isNullOrBlank!
                                                  ? "https://10.0.2.2:7293" +
                                                      "/uploads/user/ffa09aec412db3f54deadf1b3781de2a.jpg"
                                                  : "https://10.0.2.2:7293" +
                                                      _controllerEvent
                                                          .AllEvents
                                                          .value
                                                          .getEvent![itemIndex]
                                                          .users![i]
                                                          .userImage!))),
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
                      margin:
                          EdgeInsets.symmetric(horizontal: 35, vertical: 10),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Yakındakiler",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17)),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => EventPage(
                                            events: _controllerEvent
                                                .AllEvents.value,
                                          ));
                                    },
                                    child: Container(
                                      height: 35,
                                      width: 110,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      decoration: BoxDecoration(
                                          color: Colors.blueGrey[900],
                                          borderRadius:
                                              BorderRadius.circular(30)),
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
                              itemCount: FilterEvents().length > 6
                                  ? 6
                                  : FilterEvents().length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                GetEvent data = FilterEvents()[index];

                                return Column(
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
                                                        .format(DateTime.parse(
                                                            data.eventDate!)),
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
                                                              FontWeight.w700),
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
                                );
                              }),
                        ],
                      ))
                ],
              ),
      );
    });
  }

  List<GetEvent> FilterEvents() {
    List<GetEvent> data = _controllerEvent.AllEvents.value.getEvent!
        .where((element) =>
            DateTime.now()
                .difference(DateTime.parse(element.eventDate!))
                .inHours >
            -72)
        .toList();

    return data;
  }
}
