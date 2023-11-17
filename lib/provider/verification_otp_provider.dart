import 'package:flutter/cupertino.dart';

class VerificationOtpProvider with ChangeNotifier{
  bool otpVerificationSuccessful=false;
  String? trueOtpCode;
  String otpErrorMessage='';

  void setTrueOtpCode(String? value) {
    trueOtpCode = value;
    notifyListeners();
  }

  void setOptErrorMessage(String value) {
    otpErrorMessage = value;
    notifyListeners();
  }

  void verificationOptCode(String otpProposedCode) {
    otpVerificationSuccessful = trueOtpCode==otpProposedCode;
    notifyListeners();
  }
}