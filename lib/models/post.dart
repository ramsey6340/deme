import 'package:deme/models/activity.dart';

class Post {
  String? postId;
  List<String> imageUrls;
  String message;
  String? videoUrl;
  String? creationDate;
  Activity activity;
  String causeId;

  Post({
    required this.postId,
    required this.imageUrls,
    required this.message,
    required this.videoUrl,
    required this.creationDate,
    required this.activity,
    required this.causeId,
  });

  factory Post.fromJson(Map<String, dynamic> json, Activity activity) => Post(
      postId: json["activityId"],
      imageUrls: List<String>.from(json["imageUrls"].map((x) => x)),
      message: json["message"],
      videoUrl: json["videoUrl"],
      causeId: json["causeId"],
      creationDate: json["creationDate"],
      activity: activity
  );

}