import 'dart:convert';

import 'package:deme/models/cause.dart';
import 'package:deme/models/organization.dart';
import 'package:deme/models/user_model.dart';
import 'package:deme/services/cause_service.dart';
import 'package:deme/services/organization_service.dart';
import 'package:deme/services/user_service.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../models/testimony.dart';

class TestimonyService {
  static const baseServiceTestimonyUrl = "$baseUrl/service-testimony";
  UserService userService = UserService();
  CauseService causeService = CauseService();
  OrganizationService organizationService = OrganizationService();

  Future<List<Testimony>> getAllTestimony() async{
    try{
      final response = await http.get(Uri.parse('$baseServiceTestimonyUrl/'));

      if(response.statusCode == 200) {
        final responseData = json.decode(utf8.decode(response.bodyBytes));
        List<Testimony> testimonies = [];
        for(var testimony in responseData) {
          String? userId = testimony["userId"];
          String? organizationId = testimony["organizationId"];
          String? causeId = testimony["causeId"];
          if(causeId != null){
            Cause cause = await causeService.getCauseById(causeId);

            if(userId != null && userId.isNotEmpty){
              UserModel? user = await userService.getUserById(userId);
              if(user != null){
                testimonies.add(Testimony.fromJson(testimony, user, cause, null));
              }
            }

            else if(organizationId != null && organizationId.isNotEmpty){
              Organization organization = await organizationService.getOrganizationById(organizationId);
              testimonies.add(Testimony.fromJson(testimony, null, cause, organization));
            }
          }
        }
        return testimonies;
      }

      Map<String, dynamic> errorMessage = {};
      var errorResponse = json.decode(utf8.decode(response.bodyBytes));

      if (errorResponse.containsKey('message')) {
        errorMessage['message'] = errorResponse['message'];
      }
      if (errorResponse.containsKey('error')) {
        errorMessage['error'] = errorResponse['error'];
      }
      if (errorResponse.containsKey('status')) {
        errorMessage['status'] = errorResponse['status'];
      }
      if (errorResponse.containsKey('path')) {
        errorMessage['path'] = errorResponse['path'];
      }
      if (errorResponse.containsKey('timestamp')) {
        errorMessage['timestamp'] = errorResponse['timestamp'];
      }

      print("Error: $errorMessage");
      throw Exception(errorResponse);
    }catch(e) {
      throw Exception(e);
    }
  }

  Future<Testimony> getTestimonyById(String testimonyId) async{
    try{
      final response = await http.get(Uri.parse('$baseServiceTestimonyUrl/$testimonyId'));
      if(response.statusCode == 200) {
        final responseData = json.decode(utf8.decode(response.bodyBytes));

        String? userId = responseData["userId"];
        String? organizationId = responseData["organizationId"];
        String? causeId = responseData["causeId"];
        if(causeId != null){
          Cause cause = await causeService.getCauseById(causeId);

          if(userId != null && userId.isNotEmpty){
            UserModel? user = await userService.getUserById(userId);
            if(user != null){
              Testimony testimony = Testimony.fromJson(responseData, user, cause, null);
              return testimony;
            }
          }

          else if(organizationId != null && organizationId.isNotEmpty){
            Organization organization = await organizationService.getOrganizationById(organizationId);
            Testimony testimony = Testimony.fromJson(responseData, null, cause, organization);
            return testimony;          }
        }
      }

      Map<String, dynamic> errorMessage = {};
      var errorResponse = json.decode(utf8.decode(response.bodyBytes));

      if (errorResponse.containsKey('message')) {
        errorMessage['message'] = errorResponse['message'];
      }
      if (errorResponse.containsKey('error')) {
        errorMessage['error'] = errorResponse['error'];
      }
      if (errorResponse.containsKey('status')) {
        errorMessage['status'] = errorResponse['status'];
      }
      if (errorResponse.containsKey('path')) {
        errorMessage['path'] = errorResponse['path'];
      }
      if (errorResponse.containsKey('timestamp')) {
        errorMessage['timestamp'] = errorResponse['timestamp'];
      }

      print("Error: $errorMessage");
      throw Exception(errorResponse);
    }catch(e) {
      throw Exception(e);
    }
  }

}