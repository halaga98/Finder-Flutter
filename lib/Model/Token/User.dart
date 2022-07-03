class User {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? imagePath;
  String? token;
  String? about;
  String? address;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.imagePath,
      this.token,
      this.about,
      this.address});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    imagePath = json['imagePath'];
    token = json['token'];
    about = json['about'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['imagePath'] = this.imagePath;
    data['token'] = this.token;
    data['about'] = this.about;
    data['address'] = this.address;
    return data;
  }
}
