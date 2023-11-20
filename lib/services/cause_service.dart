import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants.dart';
import '../models/cause.dart';

class CauseService {
  static const baseServiceAuthUrl = "$baseUrl/service-cause";

  Future<List<Cause>> getAllCause() async{
    final response = await http.get(Uri.parse('$baseServiceAuthUrl/'));

    if(response.statusCode == 200){
      final responseData = json.decode(utf8.decode(response.bodyBytes));
      List<Cause> methodPayments = [];
      for (var methodPayment in responseData) {
        methodPayments.add(Cause.fromJson(methodPayment));
      }
      print(methodPayments);
      return methodPayments;
    }
    return [];
  }
}