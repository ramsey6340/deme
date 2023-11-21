import 'package:deme/models/organization.dart';
import 'package:flutter/cupertino.dart';

import '../models/user.dart';

class CurrentUserProvider with ChangeNotifier{
  User? currentUser;
  Organization? currentOrganization;
  String? currentUserPassword;
  String? profile;
  String? resetUserPasswordId;

  void setProfile(String? value) {
    profile=value;
    notifyListeners();
  }

  void setResetUserPasswordId(String? userId) {
    resetUserPasswordId = userId;
    notifyListeners();
  }


  /* ============Debut de traitement de l'objet User============ */

  void setCurrentUser(User? user) {
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

  void setGender(String value){
    currentUser?.gender = value;
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

  void addMethodPayment(String methodPaymentId) {
    if(!currentUser!.preferredPaymentMethods.contains(methodPaymentId)){
      currentUser?.preferredPaymentMethods.add(methodPaymentId);
    }
    notifyListeners();
  }

  void removeMethodePayment(String methodPaymentId) {
    if(currentUser!.preferredPaymentMethods.contains(methodPaymentId)){
      currentUser?.preferredPaymentMethods.remove(methodPaymentId);
    }
    notifyListeners();
  }

  void addCause(String causeId) {
    if(!currentUser!.favoriteHumanitarianCauses.contains(causeId)){
      currentUser?.favoriteHumanitarianCauses.add(causeId);
    }
    notifyListeners();
  }

  void removeCause(String causeId) {
    if(currentUser!.favoriteHumanitarianCauses.contains(causeId)){
      currentUser?.favoriteHumanitarianCauses.remove(causeId);
    }
    notifyListeners();
  }

  /* ============Fin de traitement de l'objet User============ */

  /* ============Debut de traitement de l'objet Organisation============ */

  void setCurrentOrganization(Organization? organization) {
    currentOrganization = organization;
    notifyListeners();
  }

  void setCurrentOrganizationPassword(String value) {
    currentUserPassword = value;
    notifyListeners();
  }

  void setOrganizationMatricule(String value) {
    currentOrganization?.matricule = value;
    notifyListeners();
  }

  void setOrganizationId(String value){
    currentOrganization?.organizationId = value;
    notifyListeners();
  }

  void setOrganizationNumTel(String value){
    currentOrganization?.numTel = value;
    notifyListeners();
  }
  void setOrganizationStartDateExercise(String value){
    currentOrganization?.startDateExercise = value;
    notifyListeners();
  }

  void setOrganizationName(String value){
    currentOrganization?.name = value;
    notifyListeners();
  }
  void setOrganizationEmail(String value){
    currentOrganization?.email = value;
    notifyListeners();
  }
  void setOrganizationLogin(String value){
    currentOrganization?.login = value;
    notifyListeners();
  }
  void setOrganizationImageUrl(String value){
    currentOrganization?.imageUrl = value;
    notifyListeners();
  }
  void setOrganizationDeviceType(String value){
    currentOrganization?.deviceType = value;
    notifyListeners();
  }
  void setOrganizationDelete(bool value){
    currentOrganization?.delete = value;
    notifyListeners();
  }
  void setOrganizationActivated(bool value){
    currentOrganization?.activated = value;
    notifyListeners();
  }
  void setOrganizationAnonymous(bool value){
    currentOrganization?.anonymous = value;
    notifyListeners();
  }

  void setOrganizationValid(bool value){
    currentOrganization?.valid = value;
    notifyListeners();
  }

  void setOrganizationVerified(bool value){
    currentOrganization?.verified = value;
    notifyListeners();
  }

  void setOrganizationNbSubscription(int value){
    currentOrganization?.nbSubscription = value;
    notifyListeners();
  }

  void setOrganizationType(String value){
    currentOrganization?.type = value;
    notifyListeners();
  }
  void addInOrganizationMethodPayment(String methodPaymentId){
    if(!currentOrganization!.preferredPaymentMethods.contains(methodPaymentId)){
      currentOrganization?.preferredPaymentMethods.add(methodPaymentId);
    }
    notifyListeners();
  }

  void removeInOrganizationMethodePayment(String methodPaymentId) {
    if(currentOrganization!.preferredPaymentMethods.contains(methodPaymentId)){
      currentOrganization?.preferredPaymentMethods.remove(methodPaymentId);
    }
    notifyListeners();
  }

  void addInOrganizationFavoriteCauses(String causeId) {
    if(!currentOrganization!.favoriteHumanitarianCauses.contains(causeId)){
      currentOrganization?.favoriteHumanitarianCauses.add(causeId);
    }
    notifyListeners();
  }

  void removeInOrganizationFavoriteCauses(String causeId) {
    if(currentOrganization!.favoriteHumanitarianCauses.contains(causeId)){
      currentOrganization?.favoriteHumanitarianCauses.remove(causeId);
    }
    notifyListeners();
  }

  /* ============Fin de traitement de l'objet Organisation============ */


}