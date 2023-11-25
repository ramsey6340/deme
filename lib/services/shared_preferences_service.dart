import 'package:deme/models/organization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/user_model.dart';

class SharedPreferencesService {
  final Future<SharedPreferences> _prefs  = SharedPreferences.getInstance();

  Future<void> setCurrentUser(UserModel? currentUser) async{
    // Cette methode permet d'enregistrer les données de l'utilisateur dans le cache,

    final SharedPreferences prefs = await _prefs;
    try{
      String currentUserJson = json.encode(currentUser);
      prefs.setString("currentUser", currentUserJson);
    }catch(e){
      throw Exception(e);
    }

  }

  Future<UserModel?> getCurrentUser() async {
    // Cette methode permet de récuperer les données de l'utilisateur coueant
    // dans le cache

    final SharedPreferences prefs = await _prefs;
    try{
      String? currentUserJson = prefs.getString('currentUser');
      if (currentUserJson != null) {
        UserModel user = UserModel.fromJson(json.decode(currentUserJson));
        return user;
      }
      return null;
    }catch(e) {
      throw Exception(e);
    }

  }

  Future<void> setCurrentOrganization(Organization? currentOrganization) async{
    // Cette methode permet d'enregistrer les données de l'organisation dans le cache,

    final SharedPreferences prefs = await _prefs;
    try{
      String currentOrganizationJson = json.encode(currentOrganization);
      prefs.setString("currentOrganization", currentOrganizationJson);
    }catch(e){
      throw Exception(e);
    }

  }

  Future<Organization?> getCurrentOrganization() async {
    // Cette methode permet de récuperer les données de l'organisation coueant
    // dans le cache

    final SharedPreferences prefs = await _prefs;
    try{
      String? currentOrganizationJson = prefs.getString('currentOrganization');
      if (currentOrganizationJson != null) {
        Organization organization = Organization.fromJson(json.decode(currentOrganizationJson));
        return organization;
      }
      return null;
    }catch(e) {
      throw Exception(e);
    }

  }

  Future<void> setTypeUser(String? value) async {
    final SharedPreferences prefs = await _prefs;

    try{
      if(value != null){
        prefs.setString("typeUser", value);
      }
      else{
        prefs.remove("typeUser");
      }
    }catch(e) {
      throw Exception(e);
    }
  }

  Future<String?> getTypeUser() async {
    final SharedPreferences prefs = await _prefs;

    try{
      String? typeUser = prefs.getString('typeUser');
      if (typeUser != null) {
        return typeUser;
      }
      return null;

    }catch(e) {
      throw Exception(e);
    }
  }

  Future<void> setFirstInteraction(bool value) async {
    // Cette methode modifie la valeur qui permet de savoir s'il s'agit de la prémière
    // interaction de l'utilisateur avec l'application

    final SharedPreferences prefs = await _prefs;
    try{
      prefs.setBool("firstInteraction", value);
    }catch(e){
      throw Exception(e);
    }
  }

  Future<bool?> getFirstInteraction() async {
    final SharedPreferences prefs = await _prefs;

    try{
      bool? firstInteraction = prefs.getBool('firstInteraction');
      if (firstInteraction != null) {
        return firstInteraction;
      }
      return null;

    }catch(e) {
      throw Exception(e);
    }
  }

}