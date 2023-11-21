import 'dart:convert';

import '../constants.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;

class UserService {
  static const baseServiceAuthUrl = "$baseUrl/service-user";

  Future<User?> patchUserInfo(String userId, Map<String, dynamic> userPatchInfo) async{
    final response = await http.patch(Uri.parse('$baseServiceAuthUrl/$userId'),
      body: json.encode(userPatchInfo),
      headers: {
        // Je m'assure que le type de média est défini sur JSON
        'Content-Type':'application/json'
      },
    );

    if(response.statusCode == 200) {
      final responseData = json.decode(utf8.decode(response.bodyBytes));
      User user = User.fromJson(responseData);
      return user;
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

  Future<User?> getUserById(String id) async {
    final response = await http.get(Uri.parse('$baseServiceAuthUrl/$id'));

    if(response.statusCode == 200) {
      final responseData = json.decode(utf8.decode(response.bodyBytes));
      User user = User.fromJson(responseData);
      return user;
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

  Future<bool> isLoginAvailable(String login) async{
    final response = await http.get(Uri.parse('$baseServiceAuthUrl/login/$login'));

    if(response.statusCode == 404) {
      // Cela veut dire que le login n'a pas été utilisé par un autre utilisateur,
      // donc elle est disponible
      return true;
    }
    else if(response.statusCode == 200) {
      // Le login est déjà utilisé par un autre
      return false;
    }
    else{
      return false;
    }
  }
}