import 'package:deme/models/user_model.dart';

import 'cause.dart';
import 'package:deme/models/organization.dart';

class Demand {
  String? demandId;
  String? description;
  String? videoUrl;
  String? imageUrl;
  bool active;
  String? creationDate;
  Cause cause;
  Organization guarantor;
  UserModel? user;
  Organization? organization;

  Demand({
    required this.demandId,
    required this.description,
    required this.videoUrl,
    required this.imageUrl,
    required this.active,
    required this.creationDate,
    required this.cause,
    required this.guarantor,
    required this.user,
    required this.organization
});

  factory Demand.fromJson(Map<String, dynamic> json, UserModel? user,
      Cause cause, Organization? organization, Organization guarantor) => Demand(
      demandId: json["demandId"],
      description: json["description"],
      videoUrl: json["videoUrl"],
      imageUrl: json["imageUrl"],
      active: json["active"],
      creationDate: json["creationDate"],
      guarantor: guarantor,
      cause: cause,
      user: user,
      organization: organization
  );
}