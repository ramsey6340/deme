import 'package:deme/models/activity.dart';

class Post {
  final String postId;
  final String? imageUrl;
  final String description;
  final String? videoUrl;
  final Activity activity;

  Post({
    required this.postId,
    required this.imageUrl,
    required this.description,
    required this.videoUrl,
    required this.activity
  });

}