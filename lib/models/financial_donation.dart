import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deme/models/method_payment.dart';
import 'package:deme/models/organization.dart';
import 'package:deme/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  static Future<FinancialDonation> getFromSnapshotDoc(DocumentSnapshot? snapshot) async{

    final financialDonationMap = snapshot?.data() as Map<String, dynamic>;

    // donorOrganization
    DocumentSnapshot<Map<String, dynamic>> documentSnapshotDonorOrganization = await financialDonationMap['donorOrganization'].get();
    Map<String, dynamic> donorOrganizationMap = documentSnapshotDonorOrganization.data() ?? {};// donorOrganization

    DocumentSnapshot<Map<String, dynamic>> documentSnapshotBeneficiaryOrganization = await financialDonationMap['beneficiaryOrganization'].get();
    Map<String, dynamic> beneficiaryOrganizationMap = documentSnapshotBeneficiaryOrganization.data() ?? {};

    DocumentSnapshot<Map<String, dynamic>> documentSnapshotMethodPayment = await financialDonationMap['methodPayment'].get();
    Map<String, dynamic> methodPaymentMap = documentSnapshotMethodPayment.data() ?? {};

    DocumentSnapshot<Map<String, dynamic>> documentSnapshotBeneficiaryDemand = await financialDonationMap['beneficiaryDemand'].get();
    Map<String, dynamic> beneficiaryDemandMap = documentSnapshotBeneficiaryDemand.data() ?? {};

    DocumentSnapshot<Map<String, dynamic>> documentSnapshotDonorUser = await financialDonationMap['donorUser'].get();
    Map<String, dynamic> donorUserMap = documentSnapshotDonorUser.data() ?? {};


    financialDonationMap["donorOrganization"] = donorOrganizationMap;
    financialDonationMap["beneficiaryOrganization"] = beneficiaryOrganizationMap;
    financialDonationMap["methodPayment"] = methodPaymentMap;
    financialDonationMap["donorUser"] = donorUserMap;
    financialDonationMap["beneficiaryDemand"] = beneficiaryDemandMap;



    return FinancialDonation(
        donationId: financialDonationMap["donationId"],
        used: financialDonationMap["used"],
        creationDate: financialDonationMap["creationDate"],
        amount: financialDonationMap["amount"],
        deleted: financialDonationMap["deleted"],
        donorUser: (financialDonationMap["donorUser"]==null)?null:UserModel.fromJson(financialDonationMap['donorUser']),
        donorOrganization: financialDonationMap['donorOrganization'],
        methodPayment: MethodPayment.fromJson(financialDonationMap['methodPayment']),
        beneficiaryOrganization: Organization.fromJson(financialDonationMap['beneficiaryOrganization']),
        beneficiaryDemand: (financialDonationMap["beneficiaryDemand"]==null)?null:await Demand.getFromSnapshotDoc(documentSnapshotBeneficiaryDemand)
    );
  }
}