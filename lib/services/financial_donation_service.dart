import 'package:deme/data-test/data_test.dart';
import 'package:deme/models/financial_donation.dart';

class FinancialDonationService {

  Future<List<FinancialDonation>> getAllFinancialDonation() async{
    return financialDonations;
  }
}