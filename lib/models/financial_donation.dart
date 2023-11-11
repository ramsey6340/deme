import 'package:deme/models/user.dart';

import 'package:deme/models/organization.dart';
import 'demand.dart';

class FinancialDonation {
  final String financialDonationId;
  final double amount;
  final String date;
  final User user;
  final bool isUsed;
  final Organization? beneficiaryOrga;
  final Demand? beneficiaryDemand;


  FinancialDonation({
    required this.financialDonationId,
    required this.amount,
    required this.date,
    required  this.isUsed,
    required this.user,
    required this.beneficiaryOrga,
    required this.beneficiaryDemand
});
}