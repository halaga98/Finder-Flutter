class OneEvent {
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
  List<Users>? users;
  List<Comments>? comments;

  OneEvent(
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
      this.users,
      this.comments});

  OneEvent.fromJson(Map<String, dynamic> json) {
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
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
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
    data['maxUserCount'] = this.maxUserCount;
    data['eventDate'] = this.eventDate;
    data['saveDate'] = this.saveDate;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  int? id;
  String? guideId;
  String? userName;
  String? firstName;
  String? lastName;
  String? email;
  String? imagePath;
  String? passwordSalt;
  String? passwordHash;
  bool? status;
  Null? address;
  String? secretKey;
  String? saveDate;
  Null? deleteDate;
  Null? refreshToken;
  Null? refreshTokenEndDate;
  String? about;

  Users(
      {this.id,
      this.guideId,
      this.userName,
      this.firstName,
      this.lastName,
      this.email,
      this.imagePath,
      this.passwordSalt,
      this.passwordHash,
      this.status,
      this.address,
      this.secretKey,
      this.saveDate,
      this.deleteDate,
      this.refreshToken,
      this.refreshTokenEndDate,
      this.about});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    guideId = json['guideId'];
    userName = json['userName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    imagePath = json['imagePath'];
    passwordSalt = json['passwordSalt'];
    passwordHash = json['passwordHash'];
    status = json['status'];
    address = json['address'];
    secretKey = json['secretKey'];
    saveDate = json['saveDate'];
    deleteDate = json['deleteDate'];
    refreshToken = json['refreshToken'];
    refreshTokenEndDate = json['refreshTokenEndDate'];
    about = json['about'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['guideId'] = this.guideId;
    data['userName'] = this.userName;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['imagePath'] = this.imagePath;
    data['passwordSalt'] = this.passwordSalt;
    data['passwordHash'] = this.passwordHash;
    data['status'] = this.status;
    data['address'] = this.address;
    data['secretKey'] = this.secretKey;
    data['saveDate'] = this.saveDate;
    data['deleteDate'] = this.deleteDate;
    data['refreshToken'] = this.refreshToken;
    data['refreshTokenEndDate'] = this.refreshTokenEndDate;
    data['about'] = this.about;
    return data;
  }
}

class Comments {
  int? id;
  int? eventId;
  String? saveUser;
  String? imagePath;
  String? comment;
  int? saveUserId;
  String? saveDate;

  Comments(
      {this.id,
      this.eventId,
      this.saveUser,
      this.imagePath,
      this.comment,
      this.saveUserId,
      this.saveDate});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventId = json['eventId'];
    saveUser = json['saveUser'];
    imagePath = json['imagePath'];
    comment = json['comment'];
    saveUserId = json['saveUserId'];
    saveDate = json['saveDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['eventId'] = this.eventId;
    data['saveUser'] = this.saveUser;
    data['imagePath'] = this.imagePath;
    data['comment'] = this.comment;
    data['saveUserId'] = this.saveUserId;
    data['saveDate'] = this.saveDate;
    return data;
  }
}
