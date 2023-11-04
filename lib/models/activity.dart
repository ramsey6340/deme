import 'assignment.dart';

class Activity {
  final String activityId;
  final String title;
  final String description;
  final Assignment assignment;

  Activity({
    required this.activityId,
    required this.title,
    required this.description,
    required this.assignment
});
}