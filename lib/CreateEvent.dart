import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({Key? key}) : super(key: key);

  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  String base64Image = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _header(context),
                SizedBox(
                  height: 20,
                ),
                _inputField(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _header(context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            image: DecorationImage(
                image: AssetImage("assets/images/createEvent.png"),
                fit: BoxFit.fitHeight),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Create an Event",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: "Etkinlik Başlığı",
            labelText: "Etkinlik Başlığı",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: Icon(Icons.title),
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Container(
                width: Get.width / 2,
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: "Koşu",
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: TextStyle(color: Get.theme.hintColor),
                    onChanged: (String? newValue) {
                      setState(() {});
                    },
                    items: <String>['Koşu', 'Two', 'Free', 'Four']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                width: Get.width / 2,
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: "Online",
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: TextStyle(color: Get.theme.hintColor),
                    onChanged: (String? newValue) {
                      setState(() {});
                    },
                    items: <String>['Online', 'Two', 'Free', 'Four']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 50,
                width: Get.width / 2,
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                            child: Text(
                                DateFormat(
                                  'EEE, MMM dd yyyy',
                                ).format(DateTime.now()),
                                textAlign: TextAlign.left),
                            onTap: () async {
                              final DateTime? date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100),
                              );

                              if (date != null) {
                                setState(() {
                                  DateTime(date.year, date.month, date.day, 12,
                                      30, 0);
                                  TimeOfDay(hour: 12, minute: 30);
                                });
                              }
                            }),
                      ),
                      GestureDetector(
                          child: Text(
                            DateFormat.Hm().format(DateTime.now()),
                            textAlign: TextAlign.right,
                          ),
                          onTap: () async {
                            final TimeOfDay? time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay(hour: 12, minute: 30));

                            if (time != null) {
                              setState(() {});
                            }
                          }),
                    ]),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                height: 50,
                width: Get.width / 2,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Max. Katılımcı",
                    labelText: "Max. Katılımcı",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide.none),
                    fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                    filled: true,
                    prefixIcon: Icon(Icons.title),
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            labelText: "Etkinlik Adresi",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: Icon(Icons.map),
          ),
          minLines: 3,
          maxLines: 3,
        ),
        SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            labelText: "Açıklama",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: Icon(Icons.event_note),
          ),
          minLines: 5,
          maxLines: 5,
        ),
        SizedBox(height: 10),
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
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () async {
                await Permission.camera.request();
                _imgFromCamera();
              },
              child: Icon(
                Icons.photo_camera,
                color: Get.theme.buttonColor,
              ),
            )
          ],
        ),
        SizedBox(
          height: 5,
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
                              image: MemoryImage(base64Decode(base64Image)))),
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
          height: 25,
        )
      ],
    );
  }

  void _imgFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    XFile profileImage = pickedFile!;

    if (profileImage != null) {
      List<int> fileBytes = [];
      fileBytes = new File(profileImage.path).readAsBytesSync().toList();
      //todo: crop eklenecek
      String fileContent = base64.encode(fileBytes);
      base64Image = fileContent;
      setState(() {});
    }
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
