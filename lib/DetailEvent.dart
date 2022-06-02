import 'package:flutter/material.dart';

class DetailEvent extends StatefulWidget {
  const DetailEvent({Key? key}) : super(key: key);

  @override
  State<DetailEvent> createState() => _DetailEventState();
}

class _DetailEventState extends State<DetailEvent> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Finder",
            style: TextStyle(fontSize: 30),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                _header(context),
                _body(context),
                _detail(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _header(context) {
    return Column(children: [
      Text(
        "Etkinlik Name",
        textAlign: TextAlign.left, //?
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    ]);
  }

  _body(context) {
    return Column(children: [
      Divider(
        thickness: 1,
      ),
      SizedBox(
        height: 10,
      ),
      Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          image: DecorationImage(
              image: AssetImage("assets/images/kayıtOl.jpg"),
              fit: BoxFit.fitWidth),
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Row(
        children: [
          Container(
            height: 65,
            width: 65,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/dogus.jpg'),
                fit: BoxFit.fill,
              ),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            child: Text(
              "Dogus University",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
      Divider(
        thickness: 1,
      ),
      Text(

        "27 Apr - 13:00 ",
        style: TextStyle(color: Colors.amber),
      ),
      SizedBox(
        height: 5,
      ),
      Text("İstanbul/Şişli"),
    ]);
  }
  _detail(context){
    return Column(children:[
    Container(

    ),
    ]
    );
  }
}
