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

  void setUserId(String value){
    currentUser?.userId = value;
    notifyListeners();
  }

  void setNumTel(String value){
    currentUser?.numTel = value;
    notifyListeners();
  }
  void setBirthDay(String value){
    currentUser?.birthDay = value;
    notifyListeners();
  }

  void setName(String value){
    currentUser?.name = value;
    notifyListeners();
  }
  void setEmail(String value){
    currentUser?.email = value;
    notifyListeners();
  }
  void setLogin(String value){
    currentUser?.login = value;
    notifyListeners();
  }
  void setImageUrl(String value){
    currentUser?.imageUrl = value;
    notifyListeners();
  }
  void setDeviceType(String value){
    currentUser?.deviceType = value;
    notifyListeners();
  }
  void setDelete(bool value){
    currentUser?.delete = value;
    notifyListeners();
  }
  void setActivated(bool value){
    currentUser?.activated = value;
    notifyListeners();
  }
  void setAnonymous(bool value){
    currentUser?.anonymous = value;
    notifyListeners();
  }
}