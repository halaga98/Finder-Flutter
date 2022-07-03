import 'package:flutter/foundation.dart';

class ServiceUrl {
  static final String baseUrlShareWork = "https://10.0.2.2:7293";
  //Token
  final String login = baseUrlShareWork + "/api/Token/Login";
  final String resetPassword = baseUrlShareWork + "/api/Token/ResetPassword";
  final String register = baseUrlShareWork + "/api/Token/Register";

  //Event
  final String getEvent = baseUrlShareWork + "/api/Event/Get";
  final String joinEvent = baseUrlShareWork + "/api/Event/JoinEvent";
  final String unJoinEvent = baseUrlShareWork + "/api/Event/UnJoinEvent";
  final String saveNewEvent = baseUrlShareWork + "/api/Event/SaveNewEvent";
  final String saveEventcomment =
      baseUrlShareWork + "/api/Event/SaveEventcomment";
  final String deleteEventcomment =
      baseUrlShareWork + "/api/Event/DeleteEventcomment";
  final String deleteEvent = baseUrlShareWork + "/api/Event/DeleteEvent";

  //User
  final String getUser = baseUrlShareWork + "/api/User/Get";
  final String getJoinedEvents = baseUrlShareWork + "/api/User/GetJoinedEvents";
  final String createdEvents = baseUrlShareWork + "/api/User/CreatedEvents";
  final String updateProfile = baseUrlShareWork + "/api/User/UpdateProfile";
}
