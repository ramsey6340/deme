import 'package:cloud_firestore/cloud_firestore.dart';

class Cause {
  String causeId;
  String name;
  String imageUrl;
  bool deleted;
  String? description;

  Cause({
    required this.causeId,
    required this.name,
    required this.imageUrl,
    required this.deleted,
    required this.description
  });

  factory Cause.fromJson(Map<String, dynamic> json) => Cause(
    causeId: json["causeId"],
    name: json["name"],
    description: json["description"],
    deleted: json["deleted"],
    imageUrl: json["imageUrl"],
  );

  factory Cause.fromSnapshotDoc(DocumentSnapshot? snapshot) {
    final json = snapshot?.data() as Map<String, dynamic>?;
    print("Cause: ${json.runtimeType.toString()}");

    return Cause(
      causeId: json?["causeId"],
      name: json?["name"],
      description: json?["description"],
      deleted: json?["deleted"],
      imageUrl: json?["imageUrl"],
    );
  }

  Map<String, dynamic> toJson() => {
    "causeId": causeId,
    "name": name,
    "deleted": deleted,
    "description": description,
    "imageUrl": imageUrl
  };

  static Cause getFromSnapshotDoc(DocumentSnapshot? snapshot) {
    final causeMap = snapshot?.data() as Map<String, dynamic>;

    Cause cause = Cause(
        causeId: causeMap["causeId"],
        name: causeMap["name"],
        deleted: causeMap["deleted"],
        description: causeMap["description"],
        imageUrl: causeMap["imageUrl"],
    );
    return cause;
  }
}