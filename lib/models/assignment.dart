import 'package:deme/models/organization.dart';

import 'cause.dart';

class Assignment {
  final String assignmentId;
  final String title;
  final String description;
  final Organization organization;
  final Cause cause;

  Assignment({
    required this.assignmentId,
    required this.title,
    required this.description,
    required this.organization,
    required this.cause,
  });
}