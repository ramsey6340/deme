import 'package:flutter/material.dart';

class ChangeLogScreen with ChangeNotifier{
  int logIndex = 0;

  void incrementIndex() {
    logIndex++;
    notifyListeners();
  }
}