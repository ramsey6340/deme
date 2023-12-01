import 'package:cloud_firestore/cloud_firestore.dart';

import 'user_model.dart';
import 'cause.dart';
import 'organization.dart';

class Testimony {
  String? testimonyId;
  String? message;
  String? imageUrl;
  String? videoUrl;
  String creationDate;
  bool deleted;
  UserModel? user;
  Cause cause;
  Organization? organization;

  Testimony({
    required this.testimonyId,
    required this.message,
    required this.imageUrl,
    required this.videoUrl,
    required this.creationDate,
    required this.deleted,
    required this.user,
    required this.organization,
    required this.cause
});

  factory Testimony.fromJson(Map<String, dynamic> json, UserModel? user,
      Cause cause, Organization? organization) => Testimony(
      testimonyId: json["testimonyId"],
      message: json["message"],
      imageUrl: json["imageUrl"],
      videoUrl: json["videoUrl"],
      creationDate: json["creationDate"],
      deleted: json['deleted'],
      user: user,
      organization: organization,
      cause: cause
  );

  Map<String, dynamic> toJson() => {
    "testimonyId": testimonyId,
    "message": message,
    "imageUrl": imageUrl,
    "videoUrl": videoUrl,
    "creationDate": creationDate,
    "deleted": deleted,
    "userId": user?.userId,
    "organizationId": organization?.organizationId,
    "cause": cause.causeId,
  };


  static Future<Testimony> getFromSnapshotDoc(DocumentSnapshot? snapshot) async{

    final testimonyMap = snapshot?.data() as Map<String, dynamic>;

    // Cause
    DocumentSnapshot<Map<String, dynamic>> documentSnapshotCause = await testimonyMap['cause'].get();
    Map<String, dynamic> causeMap = documentSnapshotCause.data() ?? {};

    // Organisation
    DocumentSnapshot<Map<String, dynamic>>? documentSnapshotOrganization = (testimonyMap['organization']!=null)?await testimonyMap['organization'].get():null;
    Map<String, dynamic>? organizationMap = (documentSnapshotOrganization!=null)?documentSnapshotOrganization.data(): {};

    // User
    DocumentSnapshot<Map<String, dynamic>>? documentSnapshotUser = (testimonyMap['user']!=null)? await testimonyMap['user'].get():null;
    Map<String, dynamic>? userMap = (documentSnapshotUser!=null)?documentSnapshotUser.data() : {};

    testimonyMap["cause"] = causeMap;
    testimonyMap["organization"] = organizationMap;
    testimonyMap["user"] = userMap;

    Cause cause = Cause.fromJson(causeMap);
    Organization? organization = (organizationMap?["organizationId"]=={})?null:Organization.fromJson(organizationMap!);
    UserModel? user = (userMap?["userId"]==null)?null:UserModel.fromJson(userMap!);

    Testimony testimony = Testimony(
        testimonyId: testimonyMap["testimonyId"],
        message: testimonyMap["message"],
        imageUrl: testimonyMap["imageUrl"],
        videoUrl: testimonyMap["videoUrl"],
        creationDate: testimonyMap["creationDate"],
        deleted: testimonyMap['deleted'],
        cause: cause,
        user: user,
        organization: organization
    );

    return Future.value(testimony);
  }
}