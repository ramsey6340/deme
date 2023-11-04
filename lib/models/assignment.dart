import 'package:deme/models/organization.dart';

class Assignment {
  final String assignmentId;
  final String title;
  final String description;
  final Organization organization;

  Assignment({
    required this.assignmentId,
    required this.title,
    required this.description,
    required this.organization
  });
}