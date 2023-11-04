import 'package:flutter/material.dart';

class TypeUserLogUpProvider with ChangeNotifier{
  // Le type d'utilisateur qui est entrain de s'inscrire (user ou organization)
  String? typeUserLogUp;

  void setTypeUserLogUp(String? typeUser){
    typeUserLogUp = typeUser;
    notifyListeners();
  }
}