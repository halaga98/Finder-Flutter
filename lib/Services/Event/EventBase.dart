import 'package:project/Model/Event/GetEventAll.dart';
import 'package:project/Model/Event/OneEvent.dart';

abstract class EventBase {
  Future<GetEventAll?>? GetAllEvent(
    Map<String, String> header,
  );
  Future<OneEvent?>? GetOneEvent(Map<String, String> header,
      {int id, String evetnGuid});
  Future JoinEvent(Map<String, String> header, {String evetnGuid});
  Future UnJoinEvent(Map<String, String> header, {String evetnGuid});
  Future SaveNewEvent(Map<String, String> header,
      {int id,
      String title,
      int type,
      String address,
      String description,
      DateTime eventDate,
      int maxUserCount,
      String eventImage});
  Future SaveEventcomment(Map<String, String> header,
      {int eventId, String comment});
  Future DeleteEventcomment(Map<String, String> header, {int eventCommentId});
  Future DeleteEvent(Map<String, String> header, {int eventId});
}
