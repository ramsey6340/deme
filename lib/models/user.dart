import 'dart:convert';

import 'address.dart';

class User {
  final String? userId;
  final String name;
  final String email;
  final String? login;
  final String? numTel;
  final String? imageUrl;
  final String? deviceType;
  final bool delete;
  final bool activated;
  final bool anonymous;

  User({
    required this.userId,
    required this.name,
    required this.email,
    required this.login,
    required this.numTel,
    required this.imageUrl,
    required this.deviceType,
    required this.delete,
    required this.activated,
    required this.anonymous,
  });
  factory User.fromRawJson(List<int> data) => User.fromJson(json.decode(utf8.decode(data)));
  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json["userId"],
    name: json["name"],
    email: json["email"],
    login: json["login"],
    numTel: json["numTel"],
    imageUrl: json["imageUrl"],
    deviceType: json["deviceType"],
    delete: json["delete"],
    activated: json["activated"],
    anonymous: json["anonymous"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "name": name,
    "email": email,
    "login": login,
    "numTel": numTel,
    "imageUrl": imageUrl,
    "deviceType": deviceType,
    "delete": delete,
    "activated": activated,
    "anonymous": anonymous,
  };
}