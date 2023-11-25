import 'dart:convert';
import 'package:deme/models/method_payment.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';

class PaymentService {
  static const baseServiceMethodePaymentUrl = "$baseUrl/service-method-payment";

  Future<List<MethodPayment>> getAllMethodPayment() async{
    try{
      final response = await http.get(Uri.parse('$baseServiceMethodePaymentUrl/'));

      if(response.statusCode == 200){
        final responseData = json.decode(utf8.decode(response.bodyBytes));
        List<MethodPayment> methodPayments = [];
        for (var methodPayment in responseData) {
          methodPayments.add(MethodPayment.fromJson(methodPayment));
        }
        return methodPayments;
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

  Future<MethodPayment> getMethodPaymentById(String methodPaymentId) async{
    try{
      final response = await http.get(Uri.parse('$baseServiceMethodePaymentUrl/$methodPaymentId'));
      if(response.statusCode == 200) {
        final responseData = json.decode(utf8.decode(response.bodyBytes));
        return MethodPayment.fromJson(responseData);
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
}