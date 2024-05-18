class UserModel {
  UserModel({
    this.id,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.gender,
    this.image,
    this.password,
    this.token,
  });

  UserModel.fromJson(dynamic json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    gender = json['gender'];
    image = json['image'];
    token = json['token'];
  }

  num? id;
  String? username;
  String? password;
  String? email;
  String? firstName;
  String? lastName;
  String? gender;
  String? image;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (id != null) map['id'] = id;
    if (username != null) map['username'] = username;
    if (password != null) map['password'] = password;
    if (email != null) map['email'] = email;
    if (firstName != null) map['firstName'] = firstName;
    if (lastName != null) map['lastName'] = lastName;
    if (gender != null) map['gender'] = gender;
    if (image != null) map['image'] = image;
    if (token != null) map['token'] = token;
    return map;
  }
}
