import 'package:flutter/cupertino.dart';

import '../models/user.dart';

class CurrentUserProvider with ChangeNotifier{
  User? currentUser;
  String? currentUserPassword;

  void setCurrentUser(User user) {
    currentUser = user;
    notifyListeners();
  }

  void setCurrentUserPassword(String value) {
    currentUserPassword = value;
    notifyListeners();
  }
}