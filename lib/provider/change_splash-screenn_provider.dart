import 'package:flutter/material.dart';

class ChangeSplashScreenProvider with ChangeNotifier{
  int splashIndex = 0;

  void incrementIndex() {
    if(splashIndex <2) {
      splashIndex++;
      notifyListeners();
    }
    else{
      splashIndex = 0;
    }
  }

}