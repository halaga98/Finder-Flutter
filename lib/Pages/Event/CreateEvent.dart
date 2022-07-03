import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project/Controller/ControllerBottom.dart';
import 'package:project/Controller/ControllerDB.dart';
import 'package:project/Controller/ControllerEvent.dart';
import 'package:project/Controller/ControllerUser.dart';
import 'package:project/Model/Event/OneEvent.dart';

class CreateEvent extends StatefulWidget {
  final OneEvent oneEvent;
  const CreateEvent({Key? key, required this.oneEvent}) : super(key: key);

  @override
  _CreateEventState createState() => _CreateEventState();
  get base64Image => null;
}

class _CreateEventState extends State<CreateEvent> {
  ControllerEvent _controllerEvent = Get.put(ControllerEvent());
  ControllerDB _controllerDB = Get.put(ControllerDB());
  ControllerUser _controllerUser = Get.put(ControllerUser());
  ControllerBottom _controllerBottom = Get.put(ControllerBottom());

  TextEditingController _controllerTitle = TextEditingController();
  TextEditingController _controllerCount = TextEditingController();
  TextEditingController _controllerAddress = TextEditingController();
  TextEditingController _controllerDescrip = TextEditingController();
  DateTime eventDate = DateTime.now();
  int type = 0;
  List<String> data = ['Online', 'Yüzyüze'];

  String base64Image = "";
  var m;
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      if (!widget.oneEvent.id.isNullOrBlank!) {
        _controllerTitle = TextEditingController(text: widget.oneEvent.title);
        _controllerCount = TextEditingController(
            text: widget.oneEvent.maxUserCount.toString());
        _controllerAddress =
            TextEditingController(text: widget.oneEvent.address);
        _controllerDescrip =
            TextEditingController(text: widget.oneEvent.description);
        eventDate = DateTime.parse(widget.oneEvent.eventDate!);
        type = widget.oneEvent.type!;
        setState(() {});
      } else {
        print("biz burda değiliz");
      }
      ByteData bytes = await rootBundle
          .load("assets/images/juliane-liebermann-Pw7i-YVg5uM-unsplash.jpg");
      var buffer = bytes.buffer;
      m = base64.encode(Uint8List.view(buffer));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          heroTag: "createevent",
          backgroundColor: Colors.amber,
          onPressed: () async {
            await _controllerEvent.SaveNewEvent(_controllerDB.headers(),
                    id: widget.oneEvent.id.isNullOrBlank!
                        ? 0
                        : widget.oneEvent.id,
                    title: _controllerTitle.text,
                    type: type,
                    eventDate: eventDate,
                    maxUserCount: int.parse(_controllerCount.text),
                    address: _controllerAddress.text,
                    description: _controllerDescrip.text,
                    eventImage: base64Image.isBlank! ? m : base64Image)
                .then((value) async {
              await _controllerUser.GetJoinedEvent(_controllerDB.headers());
              await _controllerUser.GetCreatedEvents(_controllerDB.headers());
              await _controllerEvent.GetAllEvent(_controllerDB.headers());
              if (!widget.oneEvent.id.isNullOrBlank!) {
                _controllerBottom.refreshdetail = true;
                _controllerBottom.update();
                Get.back();
              } else {
                _controllerBottom.goHomePage = true;
                _controllerBottom.update();
              }

              setState(() {
                _controllerTitle.clear();
                type = 0;
                eventDate = DateTime.now();
                _controllerCount.clear();
                _controllerAddress.clear();
                _controllerDescrip.clear();
                base64Image = "";
              });

              print(value);
            });
          },
          child: Icon(Icons.save),
        ),
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SingleChildScrollView(
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
      ),
    );
  }

  _header(context) {
    return Column(
      children: [
        Container(
          height: 180,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            image: DecorationImage(
                image: AssetImage("assets/images/createEvent.png"),
                fit: BoxFit.fitHeight),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Etkinlik Oluştur",
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
          controller: _controllerTitle,
          decoration: InputDecoration(
            hintText: "Etkinlik Başlığı",
            labelText: "Etkinlik Başlığı",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none),
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
                decoration: BoxDecoration(
                  color: Theme.of(context).inputDecorationTheme.fillColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    focusColor:
                        Theme.of(context).inputDecorationTheme.fillColor,
                    value: data[type],
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: TextStyle(color: Get.theme.hintColor),
                    onChanged: (String? newValue) {
                      setState(() {
                        setState(() {
                          type =
                              data.indexWhere((element) => element == newValue);
                        });
                      });
                    },
                    items: data.map<DropdownMenuItem<String>>((String value) {
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
                decoration: BoxDecoration(
                  color: Theme.of(context).inputDecorationTheme.fillColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                            child: Text(
                                DateFormat(
                                  'EEE, MMM dd yyyy',
                                ).format(eventDate),
                                textAlign: TextAlign.left),
                            onTap: () async {
                              final DateTime? date = await showDatePicker(
                                context: context,
                                initialDate: eventDate,
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100),
                              );

                              if (date != null) {
                                setState(() {
                                  eventDate = date;
                                });
                              }
                            }),
                      ),
                      GestureDetector(
                          child: Text(
                            DateFormat.Hm().format(eventDate),
                            textAlign: TextAlign.right,
                          ),
                          onTap: () async {
                            final TimeOfDay? time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay(
                                    hour: eventDate.hour,
                                    minute: eventDate.minute));
                            print(time);

                            if (time != null) {
                              setState(() {
                                eventDate = eventDate.add(Duration(
                                    hours: time.hour, minutes: time.minute));
                                print(eventDate);
                              });
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
                  controller: _controllerCount,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Max. Katılımcı",
                    labelText: "Max. Katılımcı",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide.none),
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
          controller: _controllerAddress,
          decoration: InputDecoration(
            labelText: "Etkinlik Adresi",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none),
            filled: true,
            prefixIcon: Icon(Icons.map),
          ),
          minLines: 3,
          maxLines: 3,
        ),
        SizedBox(height: 10),
        TextField(
          controller: _controllerDescrip,
          decoration: InputDecoration(
            labelText: "Açıklama",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none),
            filled: true,
            prefixIcon: Icon(Icons.event_note),
          ),
          minLines: 4,
          maxLines: 4,
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
            ),
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
