import 'dart:convert';

import 'package:deme/models/user.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';

class AuthService {

  static const baseServiceAuthUrl = "$baseUrl/service-auth";

  Future<String> createUser(String password, User user) async{
    final response = await http.post(Uri.parse('$baseServiceAuthUrl/users?password=$password'),
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
    return null;
  }
}