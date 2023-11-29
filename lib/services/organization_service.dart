import 'dart:convert';

import 'package:deme/data-test/data_test.dart';
import 'package:deme/models/organization.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';

class OrganizationService {

  static const baseServiceOrganizationUrl = "$baseUrl/service-organization";

  Future<List<Organization>> getAllOrganizations() async{
    try{
      final response = await http.get(Uri.parse('$baseServiceOrganizationUrl/'));
      if(response.statusCode == 200) {
        final responseData = json.decode(utf8.decode(response.bodyBytes));
        List<Organization> organizations = [];
        for(var organization in responseData) {
          organizations.add(Organization.fromJson(organization));
        }
        return organizations;
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

  Future<Organization> getOrganizationById(String id) async {
    final response = await http.get(Uri.parse('$baseServiceOrganizationUrl/$id'));

    if(response.statusCode == 200) {
      print("JE SUIS ICI");
      final responseData = json.decode(utf8.decode(response.bodyBytes));
      Organization organization = Organization.fromJson(responseData);
      return organization;
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

  Future<Organization?> patchOrganizationInfo(String organizationId, Map<String, dynamic> userPatchInfo) async{
    final response = await http.patch(Uri.parse('$baseServiceOrganizationUrl/$organizationId'),
      body: json.encode(userPatchInfo),
      headers: {
        // Je m'assure que le type de média est défini sur JSON
        'Content-Type':'application/json'
      },
    );

    if(response.statusCode == 200) {
      final responseData = json.decode(utf8.decode(response.bodyBytes));
      Organization organization = Organization.fromJson(responseData);
      return organization;
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
    final response = await http.get(Uri.parse('$baseServiceOrganizationUrl/login/$login'));

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