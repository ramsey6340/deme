import 'dart:convert';

import 'package:deme/data-test/data_test.dart';
import 'package:deme/models/method_payment.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';

class PaymentService {
  static const baseServiceAuthUrl = "$baseUrl/service-method-payment";

  Future<List<MethodPayment>> getAllMethodPayment() async{
    final response = await http.get(Uri.parse('$baseServiceAuthUrl/'));

    if(response.statusCode == 200){
      final responseData = json.decode(utf8.decode(response.bodyBytes));
      List<MethodPayment> methodPayments = [];
      for (var methodPayment in responseData) {
        methodPayments.add(MethodPayment.fromJson(methodPayment));
      }
      print(methodPayments);
      return methodPayments;
    }
    return [];
  }
}