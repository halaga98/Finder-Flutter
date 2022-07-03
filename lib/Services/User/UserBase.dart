import 'package:project/Model/Token/User.dart';
import 'package:project/Model/User/GetCreatedEventsBody.dart';
import 'package:project/Model/User/GetJoinedEvent.dart';

abstract class UserBase {
  Future<GetJoinedEvents?>? GetJoinedEvent(
    Map<String, String> header,
  );
  Future<GetCreatedEventsBody?>? GetCreatedEvents(
    Map<String, String> header,
  );

  Future<User?>? UpdateProfile(
    Map<String, String> header, {
    String firstName,
    String lastName,
    String email,
    String address,
    String about,
    String imagePath,
  });
}
