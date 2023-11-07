import 'package:deme/data-test/data_test.dart';
import 'package:deme/models/demand.dart';

class DemandService {

  Future<List<Demand>> getAllDemand() async {
    return demands;
  }
}