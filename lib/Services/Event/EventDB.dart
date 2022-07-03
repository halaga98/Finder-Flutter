import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:project/Model/Event/GetEventAll.dart';
import 'package:project/Model/Event/OneEvent.dart';
import 'package:project/Services/Event/EventBase.dart';
import 'package:project/Services/User/UserBase.dart';
import '../ServiceUrl.dart';

class EventDB implements EventBase {
  final ServiceUrl _serviceUrl = ServiceUrl();

  @override
  Future<GetEventAll?>? GetAllEvent(
    Map<String, String> header,
  ) async {
    var response = await http.get(
      Uri.parse(_serviceUrl.getEvent),
      headers: header,
    );

    log("req GetEvent:" + response.request!.url.toString());
    log("req GetEvent:" + response.body);

    if (response.body.isEmpty) {
      return null;
    } else {
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      return GetEventAll.fromJson(responseData);
    }
  }

  @override
  Future<OneEvent?>? GetOneEvent(Map<String, String> header,
      {int? id, String? evetnGuid}) async {
    var response = await http.get(
      Uri.parse(_serviceUrl.getEvent + "/$id?evetnGuid=$evetnGuid"),
      headers: header,
    );

    log("req GetOneEvent:" +
        "id: " +
        id.toString() +
        "evetnGuid: " +
        evetnGuid.toString());
    log("req GetOneEvent:" + response.request!.url.toString());

    log("req GetOneEvent:" + response.body);

    if (response.body.isEmpty) {
      return null;
    } else {
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      return OneEvent.fromJson(responseData);
    }
  }

  @override
  Future JoinEvent(Map<String, String> header, {String? evetnGuid}) async {
    var response = await http.post(
        Uri.parse(_serviceUrl.joinEvent + "?evetnGuid=$evetnGuid"),
        headers: header);
    log("req JoinEvent : " + evetnGuid!);
    log("res JoinEvent" + response.body);
    if (response.body.isEmpty) {
      return null;
    } else {
      try {
        final responseData = jsonDecode(response.body) as Map<String, dynamic>;
        return responseData;
      } catch (e) {
        final responseData = jsonDecode(response.body);
        Get.showSnackbar(GetSnackBar(
          message: response.body,
          duration: Duration(seconds: 3),
        ));
        return responseData;
      }
    }
  }

  @override
  Future UnJoinEvent(Map<String, String> header, {String? evetnGuid}) async {
    var responseBody = jsonEncode({
      "evetnGuid": evetnGuid,
    });
    var response = await http.post(
        Uri.parse(_serviceUrl.unJoinEvent + "?evetnGuid=$evetnGuid"),
        headers: header,
        body: responseBody);
    log("req UnJoinEvent : " + evetnGuid!);
    log("res UnJoinEvent" + response.body);
    if (response.body.isEmpty) {
      return null;
    } else {
      try {
        final responseData = jsonDecode(response.body) as Map<String, dynamic>;
        return responseData;
      } catch (e) {
        final responseData = jsonDecode(response.body);
        Get.showSnackbar(GetSnackBar(
          message: response.body,
          duration: Duration(seconds: 3),
        ));
        return responseData;
      }
    }
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
    var responseBody = jsonEncode({
      "id": id,
      "title": title,
      "type": type,
      "address": address,
      "description": description,
      "eventDate": eventDate!.toIso8601String(),
      "maxUserCount": maxUserCount,
      "eventImage": eventImage,
    });

    var response = await http.post(Uri.parse(_serviceUrl.saveNewEvent),
        headers: header, body: responseBody);
    log("req SaveNewEvent" + responseBody);
    log("res SaveNewEvent" + response.body);
    if (response.body.isEmpty) {
      return null;
    } else {
      try {
        final responseData = jsonDecode(response.body) as Map<String, dynamic>;
        return responseData;
      } catch (e) {
        final responseData = jsonDecode(response.body);
        Get.showSnackbar(GetSnackBar(
          message: responseData,
          duration: Duration(seconds: 3),
        ));
        return responseData;
      }
    }
  }

  @override
  Future DeleteEventcomment(Map<String, String> header,
      {int? eventCommentId}) async {
    var responseBody = jsonEncode({
      "eventCommentId": eventCommentId,
    });

    var response = await http.post(Uri.parse(_serviceUrl.deleteEventcomment),
        headers: header, body: responseBody);
    log("req DeleteEventcomment" + responseBody);
    log("res DeleteEventcomment" + response.body);
    if (response.body.isEmpty) {
      return null;
    } else {
      try {
        final responseData = jsonDecode(response.body) as Map<String, dynamic>;
        return responseData;
      } catch (e) {
        final responseData = jsonDecode(response.body);
        Get.showSnackbar(GetSnackBar(
          message: responseData,
          duration: Duration(seconds: 3),
        ));
        return responseData;
      }
    }
  }

  @override
  Future SaveEventcomment(Map<String, String> header,
      {int? eventId, String? comment}) async {
    var responseBody = jsonEncode({
      "eventId": eventId,
      "comment": comment,
    });

    var response = await http.post(Uri.parse(_serviceUrl.saveEventcomment),
        headers: header, body: responseBody);
    log("req SaveEventcomment" + responseBody);
    log("res SaveEventcomment" + response.body);
    if (response.body.isEmpty) {
      return null;
    } else {
      try {
        final responseData = jsonDecode(response.body) as Map<String, dynamic>;
        return responseData;
      } catch (e) {
        final responseData = jsonDecode(response.body);
        Get.showSnackbar(GetSnackBar(
          message: responseData,
          duration: Duration(seconds: 3),
        ));
        return responseData;
      }
    }
  }

  @override
  Future DeleteEvent(Map<String, String> header, {int? eventId}) async {
    var responseBody = jsonEncode({
      "eventId": eventId,
    });

    var response = await http.post(Uri.parse(_serviceUrl.deleteEvent),
        headers: header, body: responseBody);
    log("req DeleteEvent" + responseBody);
    log("res DeleteEvent" + response.body);
    if (response.body.isEmpty) {
      return null;
    } else {
      try {
        final responseData = jsonDecode(response.body) as Map<String, dynamic>;
        return responseData;
      } catch (e) {
        final responseData = jsonDecode(response.body);
        Get.showSnackbar(GetSnackBar(
          message: responseData,
          duration: Duration(seconds: 3),
        ));
        return responseData;
      }
    }
  }
}
