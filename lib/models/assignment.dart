import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deme/models/organization.dart';

import 'cause.dart';

class Assignment {
  String? assignmentId;
  String title;
  String? description;
  String? descriptionNeeds;
  String? descriptionResources;
  String? creationDate;
  bool deleted;
  Organization organization;
  Cause cause;

  Assignment({
    required this.assignmentId,
    required this.title,
    required this.description,
    required this.descriptionNeeds,
    required this.descriptionResources,
    required this.creationDate,
    required this.deleted,
    required this.organization,
    required this.cause,
  });

  factory Assignment.fromJson(Map<String, dynamic> json, Organization organization, Cause cause) => Assignment(
      assignmentId: json["assignmentId"],
      title: json["title"],
      description: json["description"],
      deleted: json["deleted"],
      descriptionNeeds: json["descriptionNeeds"],
      descriptionResources: json["descriptionResources"],
      creationDate: json["creationDate"],
      organization: organization,
      cause: cause
  );

  factory Assignment.fromFirestore(Map<String, dynamic> json) {
    return Assignment(
        assignmentId: json["assignmentId"],
        title: json["title"],
        description: json["description"],
        deleted: json["deleted"],
        descriptionNeeds: json["descriptionNeeds"],
        descriptionResources: json["descriptionResources"],
        creationDate: json["creationDate"],
        organization: Organization.fromJson(json["organization"]),
        cause: Cause.fromJson(json["cause"])
      /*organization: Organization.fromJson(json["creationDate"]),
      cause: Cause.fromJson(json["cause"])*/
    );
  }


  /*static Future<Assignment> getFromSnapshotDoc(DocumentSnapshot? snapshot) async{
    final json = snapshot?.data() as Map<String, dynamic>;
    final causeDocumentSnapshot = await json['cause'].data().get();
    final organizationDocumentSnapshot = await json['organization'].data().get();

    return Assignment(

        assignmentId: json["assignmentId"],
        title: json["title"],
        description: json["description"],
        deleted: json["deleted"],
        descriptionNeeds: json["descriptionNeeds"],
        descriptionResources: json["descriptionResources"],
        creationDate: json["creationDate"],
        organization: Organization.getFromSnapshotDoc(organizationDocumentSnapshot),
        cause: Cause.fromSnapshotDoc(causeDocumentSnapshot)
    );
  }*/

  Map<String, dynamic> toJson() => {
    "assignmentId": assignmentId,
    "title": title,
    "description": description,
    "deleted": deleted,
    "descriptionNeeds": descriptionNeeds,
    "descriptionResources": descriptionResources,
    "creationDate": creationDate,
    "causeId": cause.causeId,
    "organizationId": organization.organizationId,
  };

  Map<String, dynamic> toJsonFirestore() => {
    "assignmentId": assignmentId,
    "title": title,
    "description": description,
    "deleted": deleted,
    "descriptionNeeds": descriptionNeeds,
    "descriptionResources": descriptionResources,
    "creationDate": creationDate,
    "causeId": {},
    "organizationId": {},
  };
}