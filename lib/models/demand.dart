import 'package:deme/models/user.dart';

import 'cause.dart';
import 'package:deme/models/organization.dart';

class Demand {
  final String demandId;
  final String description;
  final String? videoUrl;
  final List<String>? imagesUrl;
  final bool inProgress;
  final Cause cause;
  final Organization guarantor;
  final User user;

  Demand({
    required this.demandId,
    required this.description,
    required this.videoUrl,
    required this.imagesUrl,
    required this.inProgress,
    required this.cause,
    required this.guarantor,
    required this.user
});
}