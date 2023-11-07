import 'package:deme/data-test/data_test.dart';
import 'package:deme/models/organization.dart';

class OrganizationService {

  Future<List<Organization>> getAllOrganizations() async {
    return organizations;
  }
}