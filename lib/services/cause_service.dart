import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants.dart';
import '../models/cause.dart';

class CauseService {
  static const baseServiceAuthUrl = "$baseUrl/service-cause";

  Future<List<Cause>> getAllCause() async{
   try{
     final response = await http.get(Uri.parse('$baseServiceAuthUrl/'));
     print("=======${response.statusCode}");

     if(response.statusCode == 200){
       final responseData = json.decode(utf8.decode(response.bodyBytes));
       List<Cause> causes = [];
       for (var cause in responseData) {
         causes.add(Cause.fromJson(cause));
       }
       return causes;
     }

     // Gestion de l'exception
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

  Future<Cause> getCauseById(String causeId) async{
    try{
      final response = await http.get(Uri.parse('$baseServiceAuthUrl/$causeId'));
      if(response.statusCode == 200){
        final responseData = json.decode(utf8.decode(response.bodyBytes));
        Cause cause = Cause.fromJson(responseData);
        return cause;
      }

      // Gestion de l'exception
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