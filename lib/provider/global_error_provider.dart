import 'package:flutter/cupertino.dart';

class GlobalErrorProvider with ChangeNotifier{
  String? loginAvailabilityError;
  String? numTelError;

  void setLoginAvailabilityError(String? errorValue) {
    loginAvailabilityError = errorValue;
    notifyListeners();
  }

  void setNumTelError(String? errorValue) {
    numTelError = errorValue;
    notifyListeners();
  }
}