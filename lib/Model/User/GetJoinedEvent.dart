class GetJoinedEvents {
  Null? createdEvents;
  List<JoinedEvents>? joinedEvents;

  GetJoinedEvents({this.createdEvents, this.joinedEvents});

  GetJoinedEvents.fromJson(Map<String, dynamic> json) {
    createdEvents = json['createdEvents'];
    if (json['joinedEvents'] != null) {
      joinedEvents = <JoinedEvents>[];
      json['joinedEvents'].forEach((v) {
        joinedEvents!.add(new JoinedEvents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdEvents'] = this.createdEvents;
    if (this.joinedEvents != null) {
      data['joinedEvents'] = this.joinedEvents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JoinedEvents {
  int? id;
  String? guidId;
  String? title;
  String? description;
  String? image;
  String? address;
  int? type;
  int? maxUserCount;
  String? eventDate;
  String? saveDate;
  int? saveUser;

  JoinedEvents(
      {this.id,
      this.guidId,
      this.title,
      this.description,
      this.image,
      this.address,
      this.type,
      this.maxUserCount,
      this.eventDate,
      this.saveDate,
      this.saveUser});

  JoinedEvents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    guidId = json['guidId'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    address = json['address'];
    type = json['type'];
    maxUserCount = json['maxUserCount'];
    eventDate = json['eventDate'];
    saveDate = json['saveDate'];
    saveUser = json['saveUser'];
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
    data['maxUserCount'] = this.maxUserCount;
    data['eventDate'] = this.eventDate;
    data['saveDate'] = this.saveDate;
    data['saveUser'] = this.saveUser;
    return data;
  }
}
