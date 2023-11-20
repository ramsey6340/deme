class Cause {
  String causeId;
  String name;
  String imageUrl;
  String? description;

  Cause({
    required this.causeId,
    required this.name,
    required this.imageUrl,
    required this.description
  });

  factory Cause.fromJson(Map<String, dynamic> json) => Cause(
    causeId: json["causeId"],
    name: json["name"],
    description: json["description"],
    imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "causeId": causeId,
    "name": name,
    "description": description,
    "imageUrl": imageUrl
  };
}