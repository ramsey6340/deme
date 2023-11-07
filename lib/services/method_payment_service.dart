import 'package:deme/data-test/data_test.dart';
import 'package:deme/models/method_payment.dart';

class MethodPaymentService {
  Future<List<MethodPayment>> getAllMethodPayment() async{
    return methodsPayment;
  }
}