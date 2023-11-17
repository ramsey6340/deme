import 'package:flutter/cupertino.dart';

class GlobalErrorProvider with ChangeNotifier{
  String? loginAvailabilityError;

  void setLoginAvailabilityError(String? errorValue) {
    loginAvailabilityError = errorValue;
    notifyListeners();
  }
}