import 'assignment.dart';

class Activity {
  String? activityId;
  String title;
  String startDate;
  String? endDate;
  String? creationDate;
  String? description;
  Assignment assignment;

  Activity({
    required this.activityId,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.creationDate,
    required this.description,
    required this.assignment
});

  factory Activity.fromJson(Map<String, dynamic> json, Assignment assignment) => Activity(
      activityId: json["activityId"],
      title: json["title"],
      startDate: json["startDate"],
      endDate: json["endDate"],
      creationDate: json["creationDate"],
      description: json["description"],
      assignment: assignment
  );
}