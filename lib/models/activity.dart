import 'package:cloud_firestore/cloud_firestore.dart';

import 'assignment.dart';

class Activity {
  String? activityId;
  String title;
  String startDate;
  String? endDate;
  bool deleted;
  String? creationDate;
  String? description;
  Assignment assignment;

  Activity({
    required this.activityId,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.deleted,
    required this.creationDate,
    required this.description,
    required this.assignment
});

  factory Activity.fromJson(Map<String, dynamic> json, Assignment assignment) => Activity(
      activityId: json["activityId"],
      title: json["title"],
      startDate: json["startDate"],
      endDate: json["endDate"],
      deleted: json["deleted"],
      creationDate: json["creationDate"],
      description: json["description"],
      assignment: assignment
  );

  static Future<Activity> getFromSnapshotDoc(DocumentSnapshot? snapshot) async{
    final json = snapshot?.data() as Map<String, dynamic>;
    final assignmentDocumentSnapshot = await json['assignmentId'].data().get();

    return Activity(
        activityId: json["activityId"],
        title: json["title"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        deleted: json["deleted"],
        creationDate: json["creationDate"],
        description: json["description"],
        assignment: Assignment.getFromSnapshotDoc(assignmentDocumentSnapshot)
    );
  }

  Map<String, dynamic> toJson() => {
    "activityId": activityId,
    "title": title,
    "startDate": startDate,
    "endDate": endDate,
    "deleted": deleted,
    "creationDate": creationDate,
    "description": description,
    "assignmentId": assignment.assignmentId
  };
}