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
}