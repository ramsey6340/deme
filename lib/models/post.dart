import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deme/models/activity.dart';
import 'package:deme/models/assignment.dart';
import 'package:deme/models/cause.dart';
import 'package:deme/models/organization.dart';
FirebaseFirestore db = FirebaseFirestore.instance;
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

  static Future<Post> getFromSnapshotDoc(DocumentSnapshot? snapshot) async{
    print("*******************ICI*******************");
    final json = snapshot?.data() as Map<String, dynamic>;
    final activityDocumentSnapshot = await json['activityId'].data().get();


    return Post(
        postId: json["postId"],
        imageUrls: List<String>.from(json["imageUrls"].map((x) => x)),
        message: json["message"],
        videoUrl: json["videoUrl"],
        creationDate: json["creationDate"],
        deleted: json['deleted'],
        activity: Activity.getFromSnapshotDoc(activityDocumentSnapshot)
    );
  }

  Map<String, dynamic> toJson() => {
    "postId": postId,
    "imageUrls": imageUrls,
    "message": message,
    "videoUrl": videoUrl,
    "creationDate": creationDate,
    "deleted": deleted,
    "activityId": activity.activityId,
  };

  // convertir un DocumentSnapshot en classe Post
  /*factory Post.fromSnapshot(DocumentSnapshot? snapshot) async {
    final data = snapshot?.data() as Map<String, dynamic>;

    final activityData = await db.collection('activities').doc(data['activityId']).get();
    final assignmentData = await db.collection('assignments').doc(activityData['assignmentId']).get();
    final organizationData = await db.collection('organizations').doc(assignmentData['organizationId']).get();
    final causeData = await db.collection('causes').doc(assignmentData['causeId']).get();

    final activityMap = activityData.data() as Map<String, dynamic>;
    final assignmentMap = assignmentData.data() as Map<String, dynamic>;
    final organizationMap = organizationData.data() as Map<String, dynamic>;
    final causeMap = causeData.data() as Map<String, dynamic>;
    return Post(
      postId: data['postId'],
      imageUrls: [],
      message: data['message'],
      videoUrl: data['videoUrl'],
      creationDate: data['creationDate'],
      deleted: data['deleted'],
      activity: Activity.fromJson(
          activityMap,
          Assignment.fromJson(assignmentMap, Organization.fromJson(organizationMap), Cause.fromJson(causeMap))),
    );
  }*/

}