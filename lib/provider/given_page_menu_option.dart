import 'package:flutter/material.dart';

import '../constants.dart';

class GivenPageMenuOptionProvider with ChangeNotifier {
  int givenOptionIndex = 0;
  void setGivenOptionIndex(int value) {
    if(value>-1 && value<kNumberOfGivenOption) {
      givenOptionIndex = value;
    }
    notifyListeners();
  }
}