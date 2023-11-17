class MethodPayment {
  String methodPaymentId;
  String name;
  String? description;
  String imageUrl;
  String? termsOfUse;

  MethodPayment({
    required this.methodPaymentId,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.termsOfUse
});

  factory MethodPayment.fromJson(Map<String, dynamic> json) => MethodPayment(
    methodPaymentId: json["methodPaymentId"],
    name: json["name"],
    description: json["description"],
    imageUrl: json["imageUrl"],
    termsOfUse: json["termsOfUse"],
  );

  Map<String, dynamic> toJson() => {
    "methodPaymentId": methodPaymentId,
    "name": name,
    "description": description,
    "imageUrl": imageUrl,
    "termsOfUse": termsOfUse
  };
}