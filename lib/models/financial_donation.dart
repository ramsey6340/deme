import 'package:deme/models/method_payment.dart';
import 'package:deme/models/organization.dart';
import 'package:deme/models/user_model.dart';
import 'demand.dart';

class FinancialDonation {
  String? donationId;
  bool? used;
  String? creationDate;
  double amount;
  bool deleted;
  UserModel? donorUser; // Le user qui fait le don
  Organization? donorOrganization; // L'organisation qui fait le don
  MethodPayment methodPayment; // Methode de paiement utilsé pour faire le don
  Organization? beneficiaryOrganization;
  Demand? beneficiaryDemand;


  FinancialDonation({
    required this.donationId,
    required this.used,
    required this.creationDate,
    required this.amount,
    required this.deleted,
    required this.donorUser,
    required this.donorOrganization,
    required this.methodPayment,
    required this.beneficiaryOrganization,
    required this.beneficiaryDemand,
});

  factory FinancialDonation.fromJson(Map<String, dynamic> json,
      UserModel? donorUser, Organization? donorOrganization,
      MethodPayment methodPayment, Organization? beneficiaryOrganization,
      Demand? beneficiaryDemand) => FinancialDonation(

      donationId: json["donationId"],
      used: json["used"],
      creationDate: json["creationDate"],
      amount: json["amount"],
      deleted: json["deleted"],
      donorUser: donorUser,
      donorOrganization: donorOrganization,
      methodPayment: methodPayment,
      beneficiaryOrganization: beneficiaryOrganization,
      beneficiaryDemand: beneficiaryDemand
  );

  Map<String, dynamic> toJson() => {
    "donationId": donationId,
    "used": used,
    "creationDate": creationDate,
    "amount": amount,
    "deleted": deleted,
    "donorUserId": donorUser?.userId,
    "donorOrganizationId": donorOrganization?.organizationId,
    "methodPaymentId": methodPayment.methodPaymentId,
    "beneficiaryOrganizationId": beneficiaryOrganization?.organizationId,
    "beneficiaryDemandId": beneficiaryDemand?.demandId,
  };
}