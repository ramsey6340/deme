import 'package:flutter/material.dart';

import '../constants.dart';

class ChangeLogScreenProvider with ChangeNotifier{
  int logIndex = 0;

  void incrementIndex() {
    if(logIndex<kNumberOfLogUpPage-1){
      logIndex++;
      notifyListeners();
    }
  }

  void twoCrementIndex() {
    if(logIndex<kNumberOfLogUpPage-2){
      logIndex+=2;
      notifyListeners();
    }
  }

  void decrementIndex() {
    if(logIndex>0){
      logIndex--;
      notifyListeners();
    }
  }

  void setIndex(int value) {
    if(value>-1 && value<kNumberOfLogUpPage){
      logIndex = value;
    }
    notifyListeners();
  }
}