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

class _DetailProfileState extends State<DetailProfile> {
  String base64Image = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Finder",
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: <Widget>[
            Container(
              constraints: BoxConstraints.expand(height: 60),
              child: TabBar(
                tabs: [
                  Tab(text: "Geçmiş Etkinlikler"),
                  Tab(text: "Benim Etkinliklerim"),
                  Tab(text: "Profilim"),
                ],
                isScrollable: true,
              ),
            ),
            Expanded(
              child: Container(
                child: TabBarView(children: [
                  Container(
                    child: Text("resim bulunucak"),
                  ),
                  Container(
                    child: Text("resim bulunucak"),
                  ),
                  Container(
                      margin: EdgeInsets.all(20),
                      child: SingleChildScrollView(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [

                          Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await Permission.mediaLibrary.request();
                                  openFile();
                                },
                                child: Icon(
                                  Icons.attach_file,
                                  color: Get.theme.buttonColor,
                                ),
                              ),

                            ],
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          base64Image == ""
                              ? Container()
                              : Container(
                                  width: 100,
                                  height: 150,
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 150,
                                        margin: EdgeInsets.only(right: 5),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: MemoryImage(base64Decode(
                                                    base64Image)))),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              base64Image = "";
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Get.theme.primaryColor,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.clear,
                                                color: Colors.black,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
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
                              fillColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.1),
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
                              fillColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.1),
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
                              fillColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.1),
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
                              fillColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.1),
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
                              fillColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.1),
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
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.1),
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
                            onTap: () {},
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
              ),
            )
          ],
        ),
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
