import 'package:flutter/material.dart';

import '../constants.dart';

class HomePageMenuOptionProvider with ChangeNotifier {
  int menuOptionIndex = 0;
  void setMenuOptionIndex(int value) {
    if(value>-1 && value<kNumberOfHomeOption) {
      menuOptionIndex = value;
    }
    notifyListeners();
  }
}