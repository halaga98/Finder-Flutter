import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailEvent extends StatefulWidget {
  @override
  _DetailEventState createState() => _DetailEventState();
}

class _DetailEventState extends State<DetailEvent>
    with TickerProviderStateMixin {
  final TextEditingController _commentController = TextEditingController();

  ScrollController _scrollController = new ScrollController();
  bool _showBackToTopButton = true;

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    IconData a = Icons.star_border;
    double yildiz = 3;
    // TODO: implement build
    return Scaffold(
      floatingActionButton: Container(
        width: 120,
        height: 45,
        decoration: BoxDecoration(
            color: Colors.green, borderRadius: BorderRadius.circular(30)),
        child: Center(
            child: Text(
          "Evet , Katıl",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )),
      ),
      body: Container(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              pinned: true,
              centerTitle: false,
              iconTheme: IconThemeData(color: Colors.black),
              title: Text(
                "Event İsmi",
                style: TextStyle(color: Colors.black),
              ),
              expandedHeight: 250,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  child: Image.asset(
                    "assets/images/etkinlik.jpg",
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
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                          "assets/images/etkinlik.jpg"))),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Kadıköy Meetup Friday",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "20 Members",
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
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Container(
                          child: Text(
                            "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32.",
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
                        title: Text("Etkinlik Zamanı : 02.06.2022 , 21:00 "),
                        subtitle: Text(""),
                        leading: Icon(Icons.info),
                      ),
                      ListTile(
                        title: Text(
                            "Etkinlik Adresi : Kadıköy / Moda / 12 Cadde "),
                        subtitle: Text(""),
                        leading: Icon(
                          Icons.location_on,
                        ),
                      ),
                      ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("1 Katılımcı"),
                            SizedBox(
                              height: 10,
                            ),
                            CircleAvatar(
                              radius: 16,
                              backgroundImage:
                                  AssetImage("assets/images/unknown.png"),
                            )
                          ],
                        ),
                        subtitle: Text(""),
                        leading: Icon(
                          Icons.group,
                        ),
                      ),
                      ListTile(
                        //login değilse login page e yönlendir
                        title: Text("Yorum ekle..."),
                        leading: Icon(Icons.comment),
                        trailing: Icon(Icons.star),
                      ),
                      ListTile(
                        title: Text("Yorumlar "),
                        leading: Icon(Icons.comment_sharp),
                        subtitle: Text("Tüm Yorumları Görüntüle..."),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
