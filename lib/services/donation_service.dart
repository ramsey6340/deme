import 'dart:convert';

import 'package:deme/data-test/data_test.dart';
import 'package:deme/models/demand.dart';
import 'package:deme/services/cause_service.dart';
import 'package:deme/services/organization_service.dart';
import 'package:deme/services/payment_service.dart';
import 'package:deme/services/user_service.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../models/financial_donation.dart';
import '../models/material_donation.dart';

class DonationService {
  static const baseServiceDemandUrl = "$baseUrl/service-donation";
  static const demandCollectionName = "demands";

  OrganizationService organizationService = OrganizationService();
  UserService userService = UserService();
  CauseService causeService = CauseService();
  PaymentService paymentService = PaymentService();



  Future<List<Demand>> getAllDemand() async {
    try{
      final response = await http.get(Uri.parse('$baseServiceDemandUrl/$demandCollectionName/'));

      if(response.statusCode == 200){
        final responseData = json.decode(utf8.decode(response.bodyBytes));

        List<Demand> demands = [];
        for(var demand in responseData) {
          String? organizationId = demand["organizationId"];
          String? userId = demand["userId"];
          String guarantorId = demand["guarantorId"];
          String causeId = demand["causeId"];
          final guarantor = await organizationService.getOrganizationById(guarantorId);
          final cause = await causeService.getCauseById(causeId);

          if(userId != null && userId.isNotEmpty) {
            final user = await userService.getUserById(userId);
            demands.add(Demand.fromJson(demand, user, cause, null, guarantor));
            continue;
          }
          else if(organizationId != null && organizationId.isNotEmpty){
            final organization = await organizationService.getOrganizationById(organizationId);
            demands.add(Demand.fromJson(demand, null, cause, organization, guarantor));
            continue;
          }
        }

        return demands;
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

      print("Error get-ID-assignment: $errorMessage");
      print("Error: $errorMessage");
      throw Exception(errorResponse);
    }catch(e){
      throw Exception(e);
    }
  }

  Future<Demand> getDemandById(String demandId) async{
    try{
      final response = await http.get(Uri.parse('$baseServiceDemandUrl/$demandCollectionName/$demandId'));
      if(response.statusCode == 200) {
        final responseData = json.decode(utf8.decode(response.bodyBytes));
        String? organizationId = responseData["organizationId"];
        String? userId = responseData["userId"];
        String guarantorId = responseData["guarantorId"];
        String causeId = responseData["causeId"];
        final guarantor = await organizationService.getOrganizationById(guarantorId);
        final cause = await causeService.getCauseById(causeId);

        if(userId != null && userId.isNotEmpty) {
          final user = await userService.getUserById(userId);
          return Demand.fromJson(responseData, user, cause, null, guarantor);
        }
        else if(organizationId != null && organizationId.isNotEmpty){
          final organization = await organizationService.getOrganizationById(organizationId);
          return Demand.fromJson(responseData, null, cause, organization, guarantor);
        }
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

      print("Error get-ID-assignment: $errorMessage");
      print("Error: $errorMessage");
      throw Exception(errorResponse);
    }catch(e) {
      throw Exception(e);
    }
  }

  Future<FinancialDonation> createFinancialDonationByOrganisationToOrganisation(
      String? organizationId, String? beneficiaryId, Map<String, dynamic> financialDonation) async{
    try{
      final response = await http.post(Uri.parse(
          '$baseServiceDemandUrl/financial/organizations/$organizationId/to/organizations/$beneficiaryId'
      ), body: json.encode(financialDonation),
        headers: {
          // Je m'assure que le type de média est défini sur JSON
          'Content-Type':'application/json'
        },
      );
      if(response.statusCode == 201) {
        print("Creation reussi");
        final responseData = json.decode(utf8.decode(response.bodyBytes));

        String donorOrganizationId = responseData["donorOrganizationId"];
        String methodPaymentId = responseData["methodPaymentId"];
        String beneficiaryOrganizationId = responseData["beneficiaryOrganizationId"];


        final donorOrganization = await organizationService.getOrganizationById(donorOrganizationId);
        final beneficiaryOrganization = await organizationService.getOrganizationById(beneficiaryOrganizationId);
        final methodPayment = await paymentService.getMethodPaymentById(methodPaymentId);

        return FinancialDonation.fromJson(responseData, null, donorOrganization,
            methodPayment, beneficiaryOrganization, null);
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

  Future<FinancialDonation> createFinancialDonationByOrganisationToDemand(
      String? organizationId, String? beneficiaryId, FinancialDonation financialDonation) async{
    try{

      final response = await http.post(Uri.parse(
          '$baseServiceDemandUrl/financial/organizations/$organizationId/to/demands/$beneficiaryId'
      ), body: json.encode(financialDonation.toJson()),
        headers: {
          // Je m'assure que le type de média est défini sur JSON
          'Content-Type':'application/json'
        },
      );
      print("Response: $response");
      if(response.statusCode == 201) {

        final responseData = json.decode(utf8.decode(response.bodyBytes));

        String donorOrganizationId = responseData["donorOrganizationId"];
        String methodPaymentId = responseData["methodPaymentId"];
        String beneficiaryDemandId = responseData["beneficiaryDemandId"];

        print("donorOrganizationId : $donorOrganizationId");
        print("methodPaymentId : $methodPaymentId");
        print("beneficiaryDemandId : $beneficiaryDemandId");

        final donorOrganization = await organizationService.getOrganizationById(donorOrganizationId);
        final beneficiaryDemand = await getDemandById(beneficiaryDemandId);
        final methodPayment = await paymentService.getMethodPaymentById(methodPaymentId);


        return FinancialDonation.fromJson(responseData, null, donorOrganization,
            methodPayment, null, beneficiaryDemand);
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

      print("Error get-ID-assignment: $errorMessage");
      print("Error: $errorMessage");
      throw Exception(errorResponse);
    }catch(e) {
      throw Exception(e);
    }
  }
  /*===========Donation Materiel============*/

  Future<MaterialDonation> createMaterialDonationByOrganisationToOrganisation(
      String? organizationId, String? beneficiaryId, Map<String, dynamic> materialDonation) async{
    print(materialDonation);
    try{
      final response = await http.post(Uri.parse(
          '$baseServiceDemandUrl/material/organizations/$organizationId/to/organizations/$beneficiaryId'
      ), body: json.encode(materialDonation),
        headers: {
          // Je m'assure que le type de média est défini sur JSON
          'Content-Type':'application/json'
        },
      );
      if(response.statusCode == 201) {
        final responseData = json.decode(utf8.decode(response.bodyBytes));

        String donorOrganizationId = responseData["donorOrganizationId"];
        String beneficiaryOrganizationId = responseData["beneficiaryOrganizationId"];


        final donorOrganization = await organizationService.getOrganizationById(donorOrganizationId);
        final beneficiaryOrganization = await organizationService.getOrganizationById(beneficiaryOrganizationId);

        return MaterialDonation.fromJson(responseData, null,
            donorOrganization,
            beneficiaryOrganization, null);
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

  Future<MaterialDonation> createMaterialDonationByOrganisationToDemand(
      String? organizationId, String? beneficiaryId, MaterialDonation materialDonation) async{
    try{
      final response = await http.post(Uri.parse(
          '$baseServiceDemandUrl/material/organizations/$organizationId/to/demands/$beneficiaryId'
      ), body: json.encode(materialDonation.toJson()),
        headers: {
          // Je m'assure que le type de média est défini sur JSON
          'Content-Type':'application/json'
        },
      );
      if(response.statusCode == 201) {
        final responseData = json.decode(utf8.decode(response.bodyBytes));

        String donorOrganizationId = responseData["donorOrganizationId"];
        String beneficiaryDemandId = responseData["beneficiaryDemandId"];


        final donorOrganization = await organizationService.getOrganizationById(donorOrganizationId);
        final beneficiaryDemand = await getDemandById(beneficiaryDemandId);

        return MaterialDonation.fromJson(responseData, null,
            donorOrganization, null, beneficiaryDemand);
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

  Future<String> createDemandByOrganization(String organizationId, String assignmentId,
      Map<String, dynamic> demandMap)  async{
    try{
      final response = await http.post(Uri.parse(
          '$baseServiceDemandUrl/demands/organizations/$organizationId?assignmentId=$assignmentId'),
        body: json.encode(demandMap),
        headers: {
          // Je m'assure que le type de média est défini sur JSON
          'Content-Type':'application/json'
        },
      );

      if(response.statusCode == 201){
        return response.body;
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
      throw Exception(errorMessage);

    }catch(e){
      throw Exception(e);
    }

  }
}