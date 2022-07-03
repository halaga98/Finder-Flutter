class GetCreatedEventsBody {
  List<CreatedEvents>? createdEvents;
  Null? joinedEvents;

  GetCreatedEventsBody({this.createdEvents, this.joinedEvents});

  GetCreatedEventsBody.fromJson(Map<String, dynamic> json) {
    if (json['createdEvents'] != null) {
      createdEvents = <CreatedEvents>[];
      json['createdEvents'].forEach((v) {
        createdEvents!.add(new CreatedEvents.fromJson(v));
      });
    }
    joinedEvents = json['joinedEvents'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.createdEvents != null) {
      data['createdEvents'] =
          this.createdEvents!.map((v) => v.toJson()).toList();
    }
    data['joinedEvents'] = this.joinedEvents;
    return data;
  }
}

class CreatedEvents {
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

  CreatedEvents(
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

  CreatedEvents.fromJson(Map<String, dynamic> json) {
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
