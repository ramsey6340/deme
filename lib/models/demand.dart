import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deme/models/user_model.dart';

import 'cause.dart';
import 'package:deme/models/organization.dart';

class Demand {
  String? demandId;
  String? description;
  String? videoUrl;
  String? imageUrl;
  bool active;
  bool deleted;
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
    required this.deleted,
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
      deleted: json["deleted"],
      creationDate: json["creationDate"],
      guarantor: guarantor,
      cause: cause,
      user: user,
      organization: organization
  );

  Map<String, dynamic> toJson() => {
    "demandId": demandId,
    "description": description,
    "videoUrl": videoUrl,
    "imageUrl": imageUrl,
    "active": active,
    "deleted": deleted,
    "creationDate": creationDate,
    "guarantorId": guarantor.organizationId,
    "causeId": cause.causeId,
    "userId": user?.userId,
    "organizationId": organization?.organizationId,
  };

  static Future<Demand> getFromSnapshotDoc(DocumentSnapshot? snapshot) async{

    final demandMap = snapshot?.data() as Map<String, dynamic>;

    // Cause
    DocumentSnapshot<Map<String, dynamic>> documentSnapshotCause = await demandMap['cause'].get();
    Map<String, dynamic> causeMap = documentSnapshotCause.data() ?? {};

    // Organisation
    DocumentSnapshot<Map<String, dynamic>>? documentSnapshotOrganization = (demandMap['organization']!=null)?await demandMap['organization'].get():null;
    Map<String, dynamic>? organizationMap = (documentSnapshotOrganization!=null)?documentSnapshotOrganization.data(): {};

    // L'organisation garant de la demande
    // Organisation
    DocumentSnapshot<Map<String, dynamic>> documentSnapshotGuarantor = (demandMap['guarantor']!=null)?await demandMap['guarantor'].get():null;
    Map<String, dynamic> guarantorMap = documentSnapshotGuarantor.data() ?? {};


    // User
    DocumentSnapshot<Map<String, dynamic>>? documentSnapshotUser = (demandMap['user']!=null)? await demandMap['user'].get():null;
    Map<String, dynamic>? userMap = (documentSnapshotUser!=null)?documentSnapshotUser.data() : {};

    demandMap["cause"] = causeMap;
    demandMap["guarantor"] = guarantorMap;
    demandMap["organization"] = organizationMap;
    demandMap["user"] = userMap;

    Cause cause = Cause.fromJson(causeMap);
    Organization guarantor = Organization.fromJson(guarantorMap);
    Organization? organization = (organizationMap?["organizationId"]=={})?null:Organization.fromJson(organizationMap!);
    UserModel? user = (userMap?["userId"]==null)?null:UserModel.fromJson(userMap!);

    Demand testimony = Demand(
        demandId: demandMap["demandId"],
        description: demandMap["description"],
        videoUrl: demandMap["videoUrl"],
        imageUrl: demandMap["imageUrl"],
        active: demandMap["active"],
        deleted: demandMap['deleted'],
        creationDate: demandMap['creationDate'],
        cause: cause,
        user: user,
        organization: organization,
        guarantor: guarantor
    );
    return Future.value(testimony);
  }

}