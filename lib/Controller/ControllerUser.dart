import 'package:get/get.dart';
import 'package:project/Model/Token/User.dart';
import 'package:project/Model/User/GetCreatedEventsBody.dart';
import 'package:project/Model/User/GetJoinedEvent.dart';
import 'package:project/Services/Event/EventBase.dart';
import 'package:project/Services/Event/EventDB.dart';
import 'package:project/Services/User/UserBase.dart';
import 'package:project/Services/User/UserDB.dart';

class ControllerUser extends GetxController implements UserBase {
  Rx<GetCreatedEventsBody> createdEvents = GetCreatedEventsBody().obs;
  Rx<GetJoinedEvents> joinedEvents = GetJoinedEvents().obs;
  UserDB _eventDB = UserDB();

  @override
  Future<GetCreatedEventsBody?>? GetCreatedEvents(
      Map<String, String> header) async {
    var value = await _eventDB.GetCreatedEvents(header);
    createdEvents = value!.obs;
    update();

    return value;
  }

  @override
  Future<GetJoinedEvents?>? GetJoinedEvent(Map<String, String> header) async {
    var value = await _eventDB.GetJoinedEvent(header);
    joinedEvents = value!.obs;
    update();

    return value;
  }

  @override
  Future<User?>? UpdateProfile(Map<String, String> header,
      {String? firstName,
      String? lastName,
      String? email,
      String? address,
      String? about,
      String? imagePath}) async {
    var value = await _eventDB.UpdateProfile(header,
        firstName: firstName,
        lastName: lastName,
        email: email,
        address: address,
        about: about,
        imagePath: imagePath);
    update();
    return value;
  }
}
