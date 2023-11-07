class Organization {
  final String organizationId;
  final String name;
  final String imageUrl;
  final bool isValid;
  final bool isVerified;
  final String matricule;
  final String type;
  final String startDateExercise;
  final int nbSubscription;

  Organization({
    required this.organizationId,
    required this.name,
    required this.imageUrl,
    required this.isValid,
    required this.isVerified,
    required this.matricule,
    required this.type,
    required this.startDateExercise,
    required this.nbSubscription
  });
}