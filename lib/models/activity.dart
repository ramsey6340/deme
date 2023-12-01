import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deme/models/cause.dart';
import 'package:deme/models/organization.dart';

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

  factory Activity.fromFirestore(Map<String, dynamic> json) {
    return Activity(
      activityId: json["activityId"],
      title: json["title"],
      startDate: json["startDate"],
      endDate: json["endDate"],
      deleted: json["deleted"],
      creationDate: json["creationDate"],
      description: json["description"],
      assignment: Assignment.fromFirestore(json["assignment"]),
      /*assignment: Assignment(assignmentId: "assignmentId",
          title: "title", description: "description", descriptionNeeds: "descriptionNeeds",
          descriptionResources: "descriptionResources",
          creationDate: "creationDate", deleted: false,
          organization: Organization(organizationId: "organizationId",
              name: "name", email: "email", numTel: "numTel", login: "login",
              imageUrl: "imageUrl", deviceType: "deviceType", deleted: false,
              activated: true, anonymous: true, profile: "profile", valid: true,
              verified: true, matricule: "matricule", type: "type",
              startDateExercise: "startDateExercise", nbSubscription: 0,
              address: null, subscribersId: [], preferredPaymentMethods: [],
              favoriteHumanitarianCauses: []),
          cause: Cause(causeId: "causeId", name: "name", imageUrl: "imageUrl", deleted: false, description: "description"))*/
    );
  }

  /*static Future<Activity> getFromSnapshotDoc(DocumentSnapshot? snapshot) async{
    final json = snapshot?.data() as Map<String, dynamic>;
    final assignmentDocumentSnapshot = await json['assignment'].data().get();

    return Activity(
        activityId: json["activityId"],
        title: json["title"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        deleted: json["deleted"],
        creationDate: json["creationDate"],
        description: json["description"],
        assignment: await Assignment.getFromSnapshotDoc(assignmentDocumentSnapshot)
    );
  }*/

  /*static Future<Activity> getFromSnapshotDoc(DocumentSnapshot? snapshot) async{
    final json = snapshot?.data() as Map<String, dynamic>;
    final assignmentDocumentSnapshot = await json['assignment'].data().get();

    return Activity(
        activityId: json["activityId"],
        title: json["title"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        deleted: json["deleted"],
        creationDate: json["creationDate"],
        description: json["description"],
        assignment: await Assignment.getFromSnapshotDoc(assignmentDocumentSnapshot)
    );
  }*/

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

  Map<String, dynamic> toJsonFirestore() => {
    "activityId": activityId,
    "title": title,
    "startDate": startDate,
    "endDate": endDate,
    "deleted": deleted,
    "creationDate": creationDate,
    "description": description,
    "assignmentId": {}
      };
}