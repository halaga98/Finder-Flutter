import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project/Controller/ControllerBottom.dart';
import 'package:project/Controller/ControllerDB.dart';
import 'package:project/Controller/ControllerEvent.dart';
import 'package:project/Controller/ControllerUser.dart';
import 'package:project/Custom/MyCircular.dart';
import 'package:project/Model/Event/OneEvent.dart';
import 'package:project/Model/User/GetJoinedEvent.dart';
import 'package:project/Pages/Event/CommentPage.dart';
import 'package:project/Pages/Event/CreateEvent.dart';

class DetailEvent extends StatefulWidget {
  final int enevtId;
  final String evetnGuid;

  const DetailEvent({Key? key, required this.enevtId, required this.evetnGuid})
      : super(key: key);
  @override
  _DetailEventState createState() => _DetailEventState();
}

class _DetailEventState extends State<DetailEvent>
    with TickerProviderStateMixin {
  final TextEditingController _commentController = TextEditingController();

  ScrollController _scrollController = new ScrollController();
  bool _showBackToTopButton = true;
  ControllerEvent _controllerEvent = Get.put(ControllerEvent());
  ControllerDB _controllerDB = Get.put(ControllerDB());
  ControllerUser _controllerUser = Get.put(ControllerUser());
  OneEvent _event = OneEvent();
  bool loading = true;
  @override
  void initState() {
    super.initState();
    GetEventDetail();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController.offset <= 400) {
            _showBackToTopButton = false; // show the back-to-top button
          } else {
            _showBackToTopButton = true; // hide the back-to-top button
          }
        });
      });
  }

  @override
  void dispose() {
    _scrollController.dispose(); // dispose the controller
    super.dispose();
  }

  GetEventDetail() async {
    await _controllerEvent.GetOneEvent(_controllerDB.headers(),
            evetnGuid: widget.evetnGuid, id: widget.enevtId)!
        .then((value) {
      _event = value!;
    });
    setState(() {
      loading = false;
    });
  }

  ControllerBottom _controllerBottom = Get.put(ControllerBottom());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControllerBottom>(builder: (a) {
      if (_controllerBottom.refreshdetail == true) {
        GetEventDetail();
        _controllerBottom.refreshdetail = false;
      }
      return loading
          ? MyCircular()
          : Scaffold(
              floatingActionButton: _controllerUser
                      .createdEvents.value.createdEvents!
                      .any((element) => element.id == widget.enevtId)
                  ? SpeedDial(
                      icon: Icons.more_vert,
                      iconTheme: IconThemeData(color: Colors.black),
                      activeIcon: Icons.more_horiz,
                      heroTag: "CollaborationPage",
                      backgroundColor: Get.theme.primaryColor,
                      visible: true,
                      elevation: 8.0,
                      shape: CircleBorder(),
                      closeManually: false,
                      buttonSize: 56.0,

                      /// If true overlay will render no matter what.
                      renderOverlay: false,
                      curve: Curves.bounceIn,
                      overlayColor: Colors.transparent,
                      overlayOpacity: 0.01,
                      children: [
                        SpeedDialChild(
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                          backgroundColor: Get.theme.primaryColor,
                          label: "Edit",
                          labelStyle:
                              TextStyle(fontSize: 18.0, color: Colors.white),
                          labelBackgroundColor: Colors.black45,
                          onTap: () async {
                            Get.to(() => CreateEvent(oneEvent: _event));
                          },
                        ),
                        SpeedDialChild(
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          backgroundColor: Get.theme.primaryColor,
                          label: "Delete",
                          labelStyle: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                          labelBackgroundColor: Colors.black45,
                          onTap: () async {
                            await _controllerEvent.DeleteEvent(
                                _controllerDB.headers(),
                                eventId: widget.enevtId);
                            await _controllerEvent.GetAllEvent(
                              _controllerDB.headers(),
                            );
                            await _controllerUser.GetCreatedEvents(
                              _controllerDB.headers(),
                            );
                            Get.back();
                          },
                        ),
                      ],
                    )
                  : _event.users!.any((element) =>
                          element.id == _controllerDB.user.value.id)
                      ? GestureDetector(
                          onTap: () async {
                            await _controllerEvent.UnJoinEvent(
                                _controllerDB.headers(),
                                evetnGuid: widget.evetnGuid);
                            GetEventDetail();
                            _controllerEvent.GetAllEvent(
                              _controllerDB.headers(),
                            );
                            _controllerUser.GetCreatedEvents(
                              _controllerDB.headers(),
                            );
                            _controllerUser.GetJoinedEvent(
                              _controllerDB.headers(),
                            );
                            setState(() {});
                          },
                          child: Container(
                              height: 40,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                  child: Text(
                                "Ayrıl",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ))))
                      : GestureDetector(
                          onTap: () async {
                            await _controllerEvent.JoinEvent(
                                _controllerDB.headers(),
                                evetnGuid: widget.evetnGuid);
                            GetEventDetail();

                            _controllerEvent.GetAllEvent(
                              _controllerDB.headers(),
                            );
                            _controllerUser.GetCreatedEvents(
                              _controllerDB.headers(),
                            );
                            _controllerUser.GetJoinedEvent(
                              _controllerDB.headers(),
                            );
                            setState(() {});
                          },
                          child: Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                                child: Text(
                              "Katıl",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            )),
                          ),
                        ),
              body: Stack(
                children: [
                  Container(
                    child: CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        SliverAppBar(
                          pinned: true,
                          centerTitle: false,
                          iconTheme: IconThemeData(color: Colors.black),
                          title: Text(
                            _event.title!,
                            style: TextStyle(color: Colors.black),
                          ),
                          expandedHeight: 250,
                          flexibleSpace: FlexibleSpaceBar(
                            background: Container(
                              child: Image.network(
                                "https://10.0.2.2:7293" + _event.image!,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                      "https://10.0.2.2:7293" +
                                                          _event.image!))),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _event.title!,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "${_event.maxUserCount!} Maksimum Kaıtlımcı",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.black,
                                    height: 15,
                                    endIndent: 13,
                                    thickness: 1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 4),
                                    child: Container(
                                      child: Text(
                                        _event.description!,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Times New Roman",
                                            letterSpacing: 1.5,
                                            wordSpacing: 4,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.black,
                                    height: 15,
                                    thickness: 1,
                                  ),
                                  ListTile(
                                    title: Text(
                                        "Etkinlik Zamanı : ${DateFormat.yMMMMd('tr').add_jm().format(DateTime.parse(_event.eventDate!))}"),
                                    subtitle: Text(""),
                                    leading: Icon(Icons.info),
                                  ),
                                  ListTile(
                                    title: Text(
                                        "Etkinlik Adresi : " + _event.address!),
                                    subtitle: Text(""),
                                    leading: Icon(
                                      Icons.location_on,
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Icon(
                                        Icons.group,
                                        color:
                                            ListTileTheme.of(context).iconColor,
                                      ),
                                      SizedBox(
                                        width: 25,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                              "${_event.users!.length} Katılımcı"),
                                          Container(
                                            height: 50,
                                            width: 50.0 * _event.users!.length,
                                            child: ListView.builder(
                                                padding: EdgeInsets.zero,
                                                shrinkWrap: true,
                                                itemCount: _event.users!.length,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    child: CircleAvatar(
                                                      radius: 16,
                                                      backgroundImage: NetworkImage(_event
                                                              .users![index]
                                                              .imagePath!
                                                              .isNullOrBlank!
                                                          ? "https://10.0.2.2:7293" +
                                                              "/uploads/user/ffa09aec412db3f54deadf1b3781de2a.jpg"
                                                          : "https://10.0.2.2:7293" +
                                                              _event
                                                                  .users![index]
                                                                  .imagePath!),
                                                    ),
                                                  );
                                                }),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  ListTile(
                                    title: Text("Yorum ekle..."),
                                    leading: Icon(Icons.comment),
                                    trailing: Icon(Icons.star),
                                    onTap: () {
                                      showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (context) =>
                                              StatefulBuilder(builder:
                                                  (BuildContext context,
                                                      StateSetter setState) {
                                                return Padding(
                                                  padding:
                                                      MediaQuery.of(context)
                                                          .viewInsets,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: ListTile(
                                                          title: TextField(
                                                            controller:
                                                                _commentController,
                                                            decoration:
                                                                InputDecoration(
                                                              hintText:
                                                                  "Yorum yazınız...",
                                                            ),
                                                            autofocus: true,
                                                          ),
                                                          leading: CircleAvatar(
                                                            backgroundImage: NetworkImage(_controllerDB
                                                                    .user
                                                                    .value
                                                                    .imagePath!
                                                                    .isNullOrBlank!
                                                                ? "https://10.0.2.2:7293" +
                                                                    "/uploads/user/ffa09aec412db3f54deadf1b3781de2a.jpg"
                                                                : "https://10.0.2.2:7293" +
                                                                    _controllerDB
                                                                        .user
                                                                        .value
                                                                        .imagePath!),
                                                          ),
                                                          trailing:
                                                              GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    await _controllerEvent.SaveEventcomment(
                                                                        _controllerDB
                                                                            .headers(),
                                                                        eventId:
                                                                            _event
                                                                                .id,
                                                                        comment:
                                                                            _commentController.text);
                                                                    await GetEventDetail();
                                                                    setState(
                                                                        () {
                                                                      _commentController
                                                                          .clear();
                                                                    });

                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Icon(
                                                                      Icons
                                                                          .send)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }));
                                    },
                                  ),
                                  ListTile(
                                    title: Text("Yorumlar "),
                                    leading: Icon(Icons.comment_sharp),
                                    subtitle:
                                        Text("Tüm Yorumları Görüntüle..."),
                                    onTap: () {
                                      Get.to(() => CommentPage(_event));
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
    });
    // TODO: implement build
  }
}
