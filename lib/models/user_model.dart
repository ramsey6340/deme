import 'dart:convert';

import 'address.dart';

class UserModel {
  String? userId;
  String name;
  String email;
  String? login;
  String? numTel;
  String? birthDay;
  String? imageUrl;
  String? deviceType;
  bool delete;
  bool activated;
  bool anonymous;
  List<String> preferredPaymentMethods;
  List<String> favoriteHumanitarianCauses;
  String profile;
  String? gender;

  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.login,
    required this.numTel,
    required this.birthDay,
    required this.imageUrl,
    required this.deviceType,
    required this.delete,
    required this.activated,
    required this.anonymous,
    required this.preferredPaymentMethods,
    required this.favoriteHumanitarianCauses,
    required this.profile,
    required this.gender
  });

  @override
  String toString() {
    return 'User{'
        'userId: $userId, '
        'name: $name, '
        'email: $email, '
        'login: $login, '
        'numTel: $numTel, '
        'birthDay: $birthDay, '
        'imageUrl: $imageUrl, '
        'deviceType: $deviceType, '
        'delete: $delete, '
        'activated: $activated, '
        'anonymous: $anonymous, '
        'preferredPaymentMethods: $preferredPaymentMethods, '
        'favoriteHumanitarianCauses: $favoriteHumanitarianCauses, '
        'profile: $profile, '
        'gender: $gender}';
  }

  /*
  // Getter
  get getNumTel => numTel;
  get getName => name;
  get getEmail => email;
  get getLogin => login;
  get getImageUrl => imageUrl;
  get getDeviceType => deviceType;
  get getDelete => delete;
  get getActivated => activated;
  get getAnonymous => anonymous;

  // Setter
  set setNumTel(String value){
    numTel = value;
  }
  set setName(String value){
    name = value;
  }
  set setEmail(String value){
    email = value;
  }
  set setLogin(String value){
    login = value;
  }
  set setImageUrl(String value){
    imageUrl = value;
  }
  set setDeviceType(String value){
    deviceType = value;
  }
  set setDelete(bool value){
    delete = value;
  }
  set setActivated(bool value){
    activated = value;
  }
  set setAnonymous(bool value){
    anonymous = value;
  }*/

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userId: json["userId"],
    name: json["name"],
    email: json["email"],
    login: json["login"],
    numTel: json["numTel"],
    birthDay: json["birthDay"],
    imageUrl: json["imageUrl"],
    deviceType: json["deviceType"],
    delete: json["delete"],
    activated: json["activated"],
    anonymous: json["anonymous"],
    profile: json["profile"],
    gender: json["gender"],
    preferredPaymentMethods: List<String>.from(json["preferredPaymentMethods"].map((x) => x)),
    favoriteHumanitarianCauses: List<String>.from(json["favoriteHumanitarianCauses"].map((x) => x))
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "name": name,
    "email": email,
    "login": login,
    "numTel": numTel,
    "birthDay": birthDay,
    "imageUrl": imageUrl,
    "deviceType": deviceType,
    "delete": delete,
    "activated": activated,
    "anonymous": anonymous,
    "profile": profile,
    "gender": gender,
    "preferredPaymentMethods": List<dynamic>.from(preferredPaymentMethods.map((x) => x)),
    "favoriteHumanitarianCauses": List<dynamic>.from(favoriteHumanitarianCauses.map((x) => x)),
  };
}