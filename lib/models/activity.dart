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