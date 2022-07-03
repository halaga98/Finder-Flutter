import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:project/Model/Token/User.dart';
import 'package:project/Model/User/GetCreatedEventsBody.dart';
import 'package:project/Model/User/GetJoinedEvent.dart';
import 'package:project/Services/User/UserBase.dart';
import '../ServiceUrl.dart';

class UserDB implements UserBase {
  final ServiceUrl _serviceUrl = ServiceUrl();

  @override
  Future<GetCreatedEventsBody?>? GetCreatedEvents(
      Map<String, String> header) async {
    var response = await http.get(
      Uri.parse(_serviceUrl.createdEvents),
      headers: header,
    );
    log("req GetCreatedEventsBody " + response.request!.url.toString());
    log("res GetCreatedEventsBody " + response.body);
    if (response.body.isEmpty) {
      return null;
    } else {
      try {
        final responseData = jsonDecode(response.body) as Map<String, dynamic>;
        return GetCreatedEventsBody.fromJson(responseData);
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
  Future<GetJoinedEvents?>? GetJoinedEvent(Map<String, String> header) async {
    var response = await http.get(
      Uri.parse(_serviceUrl.getJoinedEvents),
      headers: header,
    );
    log("req GetCreatedEventsBody " + response.request!.url.toString());
    log("res GetCreatedEventsBody " + response.body);
    if (response.body.isEmpty) {
      return null;
    } else {
      try {
        final responseData = jsonDecode(response.body) as Map<String, dynamic>;
        return GetJoinedEvents.fromJson(responseData);
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
  Future<User?>? UpdateProfile(Map<String, String> header,
      {String? firstName,
      String? lastName,
      String? email,
      String? address,
      String? about,
      String? imagePath}) async {
    var responseBody = jsonEncode({
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "address": address,
      "about": about,
      "imagePath": imagePath
    });

    var response = await http.post(Uri.parse(_serviceUrl.updateProfile),
        headers: header, body: responseBody);
    log("req UpdateProfile" + responseBody);
    log("res UpdateProfile" + response.body);
    if (response.body.isEmpty) {
      return null;
    } else {
      try {
        final responseData = jsonDecode(response.body) as Map<String, dynamic>;
        return User.fromJson(responseData);
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
