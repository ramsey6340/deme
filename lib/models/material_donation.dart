import 'package:deme/models/user_model.dart';

import 'demand.dart';
import 'method_payment.dart';
import 'organization.dart';

class MaterialDonation {
  String? donationId;
  String descriptionMaterialDonation;
  String? imageUrl;
  bool deleted;
  bool? used;
  String? creationDate;
  UserModel? donorUser; // Le user qui fait le don
  Organization? donorOrganization; // L'organisation qui fait le don
  Organization? beneficiaryOrganization;
  Demand? beneficiaryDemand;


  MaterialDonation({
    required this.donationId,
    required this.used,
    required this.creationDate,
    required this.descriptionMaterialDonation,
    required this.donorUser,
    required this.donorOrganization,
    required this.imageUrl,
    required this.deleted,
    required this.beneficiaryOrganization,
    required this.beneficiaryDemand,
  });

  factory MaterialDonation.fromJson(Map<String, dynamic> json,
      UserModel? donorUser, Organization? donorOrganization,
      Organization? beneficiaryOrganization,
      Demand? beneficiaryDemand) => MaterialDonation(

      donationId: json["donationId"],
      used: json["used"],
      creationDate: json["creationDate"],
      descriptionMaterialDonation: json["descriptionMaterialDonation"],
      imageUrl: json["imageUrl"],
      deleted: json["deleted"],
      donorUser: donorUser,
      donorOrganization: donorOrganization,
      beneficiaryOrganization: beneficiaryOrganization,
      beneficiaryDemand: beneficiaryDemand
  );

  Map<String, dynamic> toJson() => {
    "donationId": donationId, // ok
    "used": used, // ok
    "creationDate": creationDate, // ok
    "descriptionMaterialDonation": descriptionMaterialDonation, // ok
    "donorUserId": donorUser?.userId, // ok
    "deleted": deleted, // ok
    "donorOrganizationId": donorOrganization?.organizationId, // ok
    "imageUrl": imageUrl, // ok
    "beneficiaryOrganizationId": beneficiaryOrganization?.organizationId, // ok
    "beneficiaryDemandId": beneficiaryDemand?.demandId, // ok
  };
}