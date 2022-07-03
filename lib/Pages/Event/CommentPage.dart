import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project/Controller/ControllerDB.dart';
import 'package:project/Controller/ControllerEvent.dart';
import 'package:project/Model/Event/OneEvent.dart';

class CommentPage extends StatefulWidget {
  final OneEvent event;
  CommentPage(this.event);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  ControllerDB _controllerDB = Get.put(ControllerDB());
  ControllerEvent _controllerEvent = Get.put(ControllerEvent());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.event.title!),
        ),
        body: ListView.builder(
            itemCount: widget.event.comments!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      onTap: () {
                        if (_controllerDB.user.value.id ==
                            widget.event.comments![index].saveUserId) {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext bc) {
                                return SafeArea(
                                  child: Container(
                                    child: new Wrap(
                                      children: <Widget>[
                                        new ListTile(
                                            leading: new Icon(Icons.delete),
                                            title: new Text("Yorumu Sil"),
                                            onTap: () {
                                              setState(() {
                                                _controllerEvent
                                                    .DeleteEventcomment(
                                                        _controllerDB.headers(),
                                                        eventCommentId: widget
                                                            .event
                                                            .comments![index]
                                                            .id);
                                                widget.event.comments!
                                                    .removeWhere((element) =>
                                                        element.id ==
                                                        widget
                                                            .event
                                                            .comments![index]
                                                            .id);
                                              });

                                              Navigator.of(context).pop();
                                            }),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }
                      },
                      title: Text(widget.event.comments![index].saveUser!),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(widget.event
                                .comments![index].imagePath!.isNullOrBlank!
                            ? "https://10.0.2.2:7293" +
                                "/uploads/user/ffa09aec412db3f54deadf1b3781de2a.jpg"
                            : "https://10.0.2.2:7293" +
                                widget.event.comments![index].imagePath!),
                      ),
                      trailing: Text(DateFormat.yMMMMd('tr').add_jm().format(
                          DateTime.parse(
                              widget.event.comments![index].saveDate!))),
                      subtitle: Text(widget.event.comments![index].comment!),
                    ),
                    Divider(
                      thickness: 1,
                    )
                  ],
                ),
              );
            }));
  }
}
