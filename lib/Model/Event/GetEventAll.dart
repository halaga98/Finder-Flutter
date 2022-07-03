class GetEventAll {
  List<GetEvent>? getEvent;

  GetEventAll({
    this.getEvent,
  });

  GetEventAll.fromJson(Map<String, dynamic> json) {
    if (json['events'] != null) {
      getEvent = <GetEvent>[];
      json['events'].forEach((v) {
        getEvent!.add(new GetEvent.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getEvent != null) {
      data['events'] = this.getEvent!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetEvent {
  int? id;
  String? guidId;
  String? title;
  String? description;
  String? image;
  String? address;
  int? type;
  String? eventDate;
  String? saveDate;
  List<Users>? users;

  GetEvent(
      {this.id,
      this.guidId,
      this.title,
      this.description,
      this.image,
      this.address,
      this.type,
      this.eventDate,
      this.saveDate,
      this.users});

  GetEvent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    guidId = json['guidId'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    address = json['address'];
    type = json['type'];
    eventDate = json['eventDate'];
    saveDate = json['saveDate'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['guidId'] = this.guidId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['address'] = this.address;
    data['type'] = this.type;
    data['eventDate'] = this.eventDate;
    data['saveDate'] = this.saveDate;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  int? eventId;
  int? userId;
  String? firstName;
  String? lastName;
  String? userImage;
  String? saveDate;

  Users(
      {this.eventId,
      this.userId,
      this.firstName,
      this.lastName,
      this.userImage,
      this.saveDate});

  Users.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    userImage = json['userImage'];
    saveDate = json['saveDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventId'] = this.eventId;
    data['userId'] = this.userId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['userImage'] = this.userImage;
    data['saveDate'] = this.saveDate;
    return data;
  }
}
