import 'package:deme/models/activity.dart';

class Post {
  String? postId;
  List<String> imageUrls;
  String message;
  String? videoUrl;
  bool deleted;
  String? creationDate;
  Activity activity;

  Post({
    required this.postId,
    required this.imageUrls,
    required this.message,
    required this.videoUrl,
    required this.deleted,
    required this.creationDate,
    required this.activity
  });

  factory Post.fromJson(Map<String, dynamic> json, Activity activity) => Post(
      postId: json["activityId"],
      imageUrls: List<String>.from(json["imageUrls"].map((x) => x)),
      message: json["message"],
      videoUrl: json["videoUrl"],
      creationDate: json["creationDate"],
      deleted: json['deleted'],
      activity: activity
  );

  Map<String, dynamic> toJson() => {
    "postId": postId,
    "imageUrls": imageUrls,
    "message": message,
    "videoUrl": videoUrl,
    "creationDate": creationDate,
    "deleted": deleted,
    "activityId": activity.activityId,
  };

}