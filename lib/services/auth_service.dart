import 'dart:convert';

import 'package:deme/models/organization.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../models/user_model.dart';

class AuthService {

  static const baseServiceAuthUrl = "$baseUrl/service-auth";

  Future<String> createUser(String profile, String password, UserModel user) async{
    final response = await http.post(Uri.parse('$baseServiceAuthUrl/users?profile=$profile&password=$password'),
      body: json.encode(user),
      headers: {
        // Je m'assure que le type de média est défini sur JSON
        'Content-Type':'application/json'
      },
    );

    if(response.statusCode == 201) {
      print("User crée avec succès");
      return response.body;

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
  }

  Future<String> createOrganization(String profile, String password, Organization organization) async{
    final response = await http.post(Uri.parse('$baseServiceAuthUrl/organizations?profile=$profile&password=$password'),
      body: json.encode(organization),
      headers: {
        // Je m'assure que le type de média est défini sur JSON
        'Content-Type':'application/json'
      },
    );

    if(response.statusCode == 201) {
      print("Organisation crée avec succès");
      return response.body;

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
  }

  Future<String?> sendMailOtpCode(String email) async {
    final response = await http.get(Uri.parse('$baseServiceAuthUrl/verify-mail/$email'));
    if(response.statusCode == 200) {
      var responseDate = json.decode(response.body);
      return responseDate.toString();
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
  }

  Future<String?> verifyEmailForResetPassword(String email) async {
    final response = await http.get(Uri.parse('$baseServiceAuthUrl/verify-reset-mail/$email'));
    if(response.statusCode == 200) {
      var responseDate = response.body;
      return responseDate;
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
  }

  Future<String?> resetPassword(String userId, String newPassword) async {
    final response = await http.patch(Uri.parse('$baseServiceAuthUrl/reset-password/$userId?newPassword=$newPassword'));
    if(response.statusCode == 200) {
      final responseData = response.body;
      return responseData;
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
  }
}