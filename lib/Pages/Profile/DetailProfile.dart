import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:project/Controller/ControllerDB.dart';
import 'package:project/Controller/ControllerUser.dart';
import 'package:project/Custom/MyCircular.dart';
import 'package:project/Model/User/GetCreatedEventsBody.dart';
import 'package:project/Model/User/GetJoinedEvent.dart';
import 'package:project/Pages/Event/DetailEvent.dart';
import 'package:project/Themese/Themes.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';

class DetailProfile extends StatefulWidget {
  const DetailProfile({Key? key}) : super(key: key);

  @override
  State<DetailProfile> createState() => _DetailProfileState();

  get base64Image => null;
}

class _DetailProfileState extends State<DetailProfile>
    with SingleTickerProviderStateMixin {
  String base64Image = "";
  late TabController _tabController;
  TextEditingController _textmail = TextEditingController();
  TextEditingController _textname = TextEditingController();
  TextEditingController _textabout = TextEditingController();
  bool loading = true;
  List<Tab> myTabs = <Tab>[
    Tab(
      text: "Geçmiş Etkinlikler",
    ),
    Tab(text: "Etkinliklerim"),
    Tab(text: "Profilim"),
  ];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await getJoinedEvents();
      await getCreatedEvent();
      initializeDateFormatting();
      _textmail = TextEditingController(text: _controllerDB.user.value.email);
      _textname = TextEditingController(
          text: _controllerDB.user.value.firstName! +
              " " +
              _controllerDB.user.value.lastName!);
      _textabout = TextEditingController(text: _controllerDB.user.value.about);
      setState(() {
        loading = false;
      });
    });

    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  ControllerDB _controllerDB = Get.put(ControllerDB());
  ControllerUser _controllerUser = Get.put(ControllerUser());
  getJoinedEvents() async {
    await _controllerUser.GetJoinedEvent(_controllerDB.headers());
  }

  getCreatedEvent() async {
    await _controllerUser.GetCreatedEvents(_controllerDB.headers());
  }

  updateProfile(
      {String firstName = "",
      String lastName = "",
      String email = "",
      String address = "",
      String about = "",
      String imagePath = ""}) async {
    await _controllerUser.UpdateProfile(_controllerDB.headers(),
            firstName: firstName,
            lastName: lastName,
            email: email,
            address: address,
            about: about,
            imagePath: imagePath)!
        .then((value) {
      _controllerDB.user.value.firstName = value!.firstName;
      _controllerDB.user.value.lastName = value.lastName;
      _controllerDB.user.value.address = value.address;
      _controllerDB.user.value.about = value.about;
      _controllerDB.user.value.imagePath = value.imagePath;
      _controllerDB.user.value.email = value.email;
      _controllerDB.update();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControllerDB>(builder: (userData) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Finder",
            style: TextStyle(fontSize: 30),
          ),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 23, vertical: 15),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      await Permission.mediaLibrary.request();
                      await Permission.camera.request();
                      _showPicker(context);
                    },
                    child: Container(
                      width: 70,
                      height: 70,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(_controllerDB
                                      .user.value.imagePath.isNullOrBlank!
                                  ? "https://10.0.2.2:7293/uploads/user/ffa09aec412db3f54deadf1b3781de2a.jpg"
                                  : "https://10.0.2.2:7293" +
                                      _controllerDB.user.value.imagePath!))),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _controllerDB.user.value.firstName! +
                              " " +
                              _controllerDB.user.value.lastName!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          _controllerDB.user.value.email!.toLowerCase(),
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      _tabController.animateTo(2);
                    },
                    child: Container(
                      height: 35,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.amber),
                      child: Center(
                        child: Text("Profili Düzenle"),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              constraints: BoxConstraints.expand(height: 60),
              child: TabBar(
                controller: _tabController,
                labelPadding: EdgeInsets.symmetric(horizontal: 23),
                tabs: myTabs,
                isScrollable: true,
                labelColor: Get.theme.secondaryHeaderColor,
              ),
            ),
            loading
                ? MyCircular()
                : Expanded(
                    child: TabBarView(controller: _tabController, children: [
                      _controllerUser.joinedEvents.value.joinedEvents!.length ==
                              0
                          ? Container(
                              height: 150,
                              width: Get.width,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/Empty-cuate.png"))),
                            )
                          : ListView.builder(
                              itemCount: _controllerUser
                                  .joinedEvents.value.joinedEvents!.length,
                              padding: EdgeInsets.only(top: 20),
                              itemBuilder: (context, index) {
                                JoinedEvents joined = _controllerUser
                                    .joinedEvents.value.joinedEvents![index];
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(() => DetailEvent(
                                          enevtId: joined.id!,
                                          evetnGuid: joined.guidId!,
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
                                    margin: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 20),
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
                                                      DateFormat.yMMMMd('tr')
                                                          .add_jm()
                                                          .format(DateTime
                                                              .parse(joined
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
                                                        joined.title!,
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
                                                    Text(joined.address!),
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
                                                              "https://10.0.2.2:7293" +
                                                                  joined
                                                                      .image!),
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
                      _controllerUser
                                  .createdEvents.value.createdEvents!.length ==
                              0
                          ? Container(
                              height: 150,
                              width: Get.width,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/Empty-pana.png"))),
                            )
                          : ListView.builder(
                              itemCount: _controllerUser
                                  .createdEvents.value.createdEvents!.length,
                              padding: EdgeInsets.only(top: 20),
                              itemBuilder: (context, index) {
                                CreatedEvents created = _controllerUser
                                    .createdEvents.value.createdEvents![index];
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(() => DetailEvent(
                                          enevtId: created.id!,
                                          evetnGuid: created.guidId!,
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
                                    margin: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 20),
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
                                                      DateFormat.yMMMMd('tr')
                                                          .add_jm()
                                                          .format(DateTime
                                                              .parse(created
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
                                                        created.title!,
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
                                                    Text(created.address!),
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
                                                              "https://10.0.2.2:7293" +
                                                                  created
                                                                      .image!),
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
                      Container(
                          margin: EdgeInsets.all(20),
                          child: SingleChildScrollView(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Hesabın",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                thickness: 1,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: _textmail,
                                decoration: InputDecoration(
                                  hintText: "E-posta Adresin",
                                  labelText: "E-posta Adresin",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide.none),
                                  filled: true,
                                  prefixIcon: Icon(Icons.email),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextField(
                                controller: _textname,
                                decoration: InputDecoration(
                                  hintText: "Adın Soyadın",
                                  labelText: "Adın Soyadın",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide.none),
                                  filled: true,
                                  prefixIcon: Icon(Icons.account_circle),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextField(
                                controller: _textabout,
                                decoration: InputDecoration(
                                  labelText: "Hakkında",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide.none),
                                  filled: true,
                                  prefixIcon: Icon(Icons.event_note),
                                ),
                                minLines: 5,
                                maxLines: 5,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  updateProfile(
                                      firstName:
                                          _textname.text.split(" ").first,
                                      lastName: _textname.text.split(" ").last,
                                      about: _textabout.text);
                                },
                                child: Container(
                                  height: 35,
                                  width: 90,
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                      child: Text(
                                    "Kaydet",
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  _controllerDB.user.value.id = null;
                                  _controllerDB.updateLoginState(Login.SignIn);
                                  final a =
                                      await SharedPreferences.getInstance();
                                  await a.clear();
                                  await a.reload();
                                },
                                child: Container(
                                  height: 35,
                                  width: 90,
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                      child: Text(
                                    "Oturumu Kapat",
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ),
                              )
                            ],
                          ))),
                    ]),
                  )
          ],
        ),
      );
    });
  }

  Future<void> openFile() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      XFile profileImage = pickedFile!;

      if (profileImage != null) {
        List<int> fileBytes = [];
        fileBytes = new File(profileImage.path).readAsBytesSync().toList();
        //todo: crop eklenecek
        String fileContent = base64.encode(fileBytes);
        base64Image = fileContent;
        await updateProfile(imagePath: base64Image);
        setState(() {});
      }

      print('aaa');
    } catch (e) {}
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () async {
                        await _onImageButtonPressed(ImageSource.gallery,
                            context: context);

                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () async {
                      await _onImageButtonPressed(ImageSource.camera,
                          context: context);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _onImageButtonPressed(ImageSource source,
      {required BuildContext context}) async {
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: source);
    XFile profileImage = pickedFile!;

    if (profileImage != null) {
      List<int> fileBytes = [];
      fileBytes = new File(profileImage.path).readAsBytesSync().toList();
      //todo: crop eklenecek
      String fileContent = base64.encode(fileBytes);
      base64Image = fileContent;
      await updateProfile(imagePath: base64Image);
      setState(() {});
    }
  }
}
