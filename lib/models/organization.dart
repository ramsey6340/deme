import 'address.dart';

class Organization {
  String? organizationId;
  String name;
  String email;
  String? numTel;
  String? imageUrl;
  String? login;
  String? deviceType;
  bool delete;
  bool activated;
  bool anonymous;
  String profile;
  bool valid;
  bool verified;
  String? matricule;
  String type;
  String? startDateExercise;
  int nbSubscription; // nombre d'abonnement
  Address? address;
  List<String> subscribersId;
  List<String> preferredPaymentMethods;
  List<String> favoriteHumanitarianCauses;

  Organization({
    required this.organizationId,
    required this.name,
    required this.email,
    required this.numTel,
    required this.login,
    required this.imageUrl,
    required this.deviceType,
    required this.delete,
    required this.activated,
    required this.anonymous,
    required this.profile,
    required this.valid,
    required this.verified,
    required this.matricule,
    required this.type,
    required this.startDateExercise,
    required this.nbSubscription,
    required this.address,
    required this.subscribersId,
    required this.preferredPaymentMethods,
    required this.favoriteHumanitarianCauses
  });

  @override
  String toString() {
    return 'Organization{'
        'organizationId: $organizationId, '
        'name: $name, '
        'email: $email, '
        'login: $login, '
        'numTel: $numTel, '
        'startDateExercise: $startDateExercise, '
        'imageUrl: $imageUrl, '
        'deviceType: $deviceType, '
        'delete: $delete, '
        'activated: $activated, '
        'anonymous: $anonymous, '
        'valid: $valid, '
        'verified: $verified, '
        'matricule: $matricule, '
        'type: $type, '
        'nbSubscription: $nbSubscription, '
        'address: $address, '
        'subscribersId: $subscribersId, '
        'preferredPaymentMethods: $preferredPaymentMethods, '
        'favoriteHumanitarianCauses: $favoriteHumanitarianCauses, '
        'profile: $profile}';
  }

  factory Organization.fromJson(Map<String, dynamic> json) => Organization(
      organizationId: json["userId"],
      name: json["name"],
      email: json["email"],
      login: json["login"],
      numTel: json["numTel"],
      startDateExercise: json["startDateExercise"],
      imageUrl: json["imageUrl"],
      deviceType: json["deviceType"],
      delete: json["delete"],
      activated: json["activated"],
      anonymous: json["anonymous"],
      profile: json["profile"],
      valid: json["valid"],
      verified: json["verified"],
      matricule: json["matricule"],
      type: json["type"],
      nbSubscription: json["nbSubscription"],
      address: json["address"],
      preferredPaymentMethods: List<String>.from(json["preferredPaymentMethods"].map((x) => x)),
      favoriteHumanitarianCauses: List<String>.from(json["favoriteHumanitarianCauses"].map((x) => x)),
      subscribersId: List<String>.from(json["subscribersId"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "organizationId": organizationId,
    "name": name,
    "email": email,
    "login": login,
    "numTel": numTel,
    "startDateExercise": startDateExercise,
    "imageUrl": imageUrl,
    "deviceType": deviceType,
    "delete": delete,
    "activated": activated,
    "anonymous": anonymous,
    "valid": valid,
    "verified": verified,
    "matricule": matricule,
    "type": type,
    "nbSubscription": nbSubscription,
    "address": address,
    "profile": profile,
    "subscribersId": List<dynamic>.from(subscribersId.map((x) => x)),
    "preferredPaymentMethods": List<dynamic>.from(preferredPaymentMethods.map((x) => x)),
    "favoriteHumanitarianCauses": List<dynamic>.from(favoriteHumanitarianCauses.map((x) => x)),
  };
}