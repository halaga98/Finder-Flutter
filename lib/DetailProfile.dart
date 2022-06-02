import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:project/Themes.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

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
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    openFile();
                  },
                  child: Container(
                    width: 70,
                    height: 70,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.amber,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: MemoryImage(base64Decode(base64Image)))),
                    child: Container(
                      child: base64Image != ""
                          ? Container()
                          : Icon(
                              Icons.photo_camera,
                              color: Get.theme.buttonColor,
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  child: Column(
                    children: [
                      Text(
                        "Sümeyye Korkmaz",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        "@sümeyyekorkmaz",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
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
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              Container(
                height: 150,
                width: Get.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/Empty-cuate.png"))),
              ),
              Container(
                height: 150,
                width: Get.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/Empty-pana.png"))),
              ),
              Container(
                  margin: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Divider(
                        thickness: 1,
                      ),
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
                      IntlPhoneField(
                        decoration: InputDecoration(
                          hintText: "Telefon ",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none),
                          filled: true,
                          prefixIcon: Icon(Icons.email),
                        ),
                        initialCountryCode: 'IN',
                        onChanged: (phone) {
                          print(phone.completeNumber);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Kullanıcı Adı",
                          labelText: "Kullanıcı Adı",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none),
                          filled: true,
                          prefixIcon: Icon(Icons.arrow_forward_sharp),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Bilgilerin",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
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
                      Container(
                        width: Get.width / 2,
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).inputDecorationTheme.fillColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: "Istanbul",
                            icon: const Icon(Icons.location_city),
                            elevation: 16,
                            style: TextStyle(color: Get.theme.hintColor),
                            onChanged: (String? newValue) {
                              setState(() {});
                            },
                            items: <String>[
                              'Istanbul',
                              'Ankara ',
                              'İzmir',
                              'Giresun'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {},
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
                        onTap: () {
                          Get.back();
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
        setState(() {});
      }

      print('aaa');
    } catch (e) {}
  }
}
