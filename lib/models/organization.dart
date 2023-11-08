import 'package:deme/models/user.dart';

import 'address.dart';

class Organization {
  final String organizationId;
  final String name;
  final String imageUrl;
  final String login;
  final bool isValid;
  final bool isVerified;
  final String matricule;
  final String type;
  final String startDateExercise;
  final int nbSubscription;
  final Address address;

  Organization({
    required this.organizationId,
    required this.name,
    required this.login,
    required this.imageUrl,
    required this.isValid,
    required this.isVerified,
    required this.matricule,
    required this.type,
    required this.startDateExercise,
    required this.nbSubscription,
    required this.address
  });
}