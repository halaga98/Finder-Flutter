import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


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
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),

                child: Column(
                  children: [
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 6,
                        shrinkWrap: true,

                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text("Etkinlikler"),
                              onTap: () {},
                            ),
                          );
                        })
                  ],
                ))
          ],
        ));
  }
}
