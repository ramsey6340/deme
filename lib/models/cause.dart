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

  Map<String, dynamic> toJson() => {
    "causeId": causeId,
    "name": name,
    "deleted": deleted,
    "description": description,
    "imageUrl": imageUrl
  };
}