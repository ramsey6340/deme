import 'user_model.dart';
import 'cause.dart';
import 'organization.dart';

class Testimony {
  String? testimonyId;
  String? message;
  String? imageUrl;
  String? videoUrl;
  String creationDate;
  UserModel? user;
  Cause cause;
  Organization? organization;

  Testimony({
    required this.testimonyId,
    required this.message,
    required this.imageUrl,
    required this.videoUrl,
    required this.creationDate,
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
      user: user,
      organization: organization,
      cause: cause
  );
}