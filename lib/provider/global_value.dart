import 'package:flutter/foundation.dart';

class GlobalValue with ChangeNotifier{
  String? beneficiaryDonation;

  void setBeneficiaryDonation(value) {
    beneficiaryDonation=value;
    notifyListeners();
  }

}