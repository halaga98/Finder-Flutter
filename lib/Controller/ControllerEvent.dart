import 'package:get/get.dart';
import 'package:project/Model/Event/GetEventAll.dart';
import 'package:project/Model/Event/OneEvent.dart';
import 'package:project/Services/Event/EventBase.dart';
import 'package:project/Services/Event/EventDB.dart';

class ControllerEvent extends GetxController implements EventBase {
  Rx<GetEventAll> AllEvents = GetEventAll().obs;
  EventDB _eventDB = EventDB();
  @override
  Future<GetEventAll?>? GetAllEvent(Map<String, String> header) async {
    var value = await _eventDB.GetAllEvent(header);
    AllEvents = value!.obs;
    update();
    return value;
  }

  @override
  Future<OneEvent?>? GetOneEvent(Map<String, String> header,
      {int? id, String? evetnGuid}) async {
    var value =
        await _eventDB.GetOneEvent(header, id: id, evetnGuid: evetnGuid);
    return value;
  }

  @override
  Future JoinEvent(Map<String, String> header, {String? evetnGuid}) async {
    var value = await _eventDB.JoinEvent(header, evetnGuid: evetnGuid);
    return value;
  }

  @override
  Future SaveNewEvent(Map<String, String> header,
      {int? id,
      String? title,
      int? type,
      String? address,
      String? description,
      DateTime? eventDate,
      int? maxUserCount,
      String? eventImage}) async {
    var value = await _eventDB.SaveNewEvent(header,
        id: id,
        title: title,
        type: type,
        address: address,
        description: description,
        eventDate: eventDate,
        maxUserCount: maxUserCount,
        eventImage: eventImage);
    return value;
  }

  @override
  Future UnJoinEvent(Map<String, String> header, {String? evetnGuid}) async {
    var value = await _eventDB.UnJoinEvent(header, evetnGuid: evetnGuid);
    return value;
  }

  @override
  Future DeleteEventcomment(Map<String, String> header,
      {int? eventCommentId}) async {
    var value = await _eventDB.DeleteEventcomment(header,
        eventCommentId: eventCommentId);
    return value;
  }

  @override
  Future SaveEventcomment(Map<String, String> header,
      {int? eventId, String? comment}) async {
    var value = await _eventDB.SaveEventcomment(header,
        eventId: eventId, comment: comment);
    return value;
  }

  @override
  Future DeleteEvent(Map<String, String> header, {int? eventId}) async {
    var value = await _eventDB.DeleteEvent(header, eventId: eventId);
    return value;
  }
}
