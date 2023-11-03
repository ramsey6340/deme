import 'package:flutter/material.dart';

import '../constants.dart';

class ChangeLogScreen with ChangeNotifier{
  int logIndex = 0;

  void incrementIndex() {
    if(logIndex<kNumberOfLogUpPage-1){
      logIndex++;
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