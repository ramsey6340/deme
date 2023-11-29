import 'package:deme/constants.dart';
import 'package:deme/models/demand.dart';
import 'package:deme/models/organization.dart';
import 'package:deme/services/donation_service.dart';
import 'package:deme/services/organization_service.dart';
import 'package:deme/size_config.dart';
import 'package:intl/intl.dart';
import 'package:deme/widgets/profile_img.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../../data-test/data_test.dart';
import '../../../widgets/demand_container.dart';
import '../../../widgets/organization_shimmer.dart';
import '../../../widgets/post_container.dart';
import '../../../widgets/post_shimmer.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Future<List<Demand>> futureDemand;
  DonationService demandService = DonationService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureDemand = demandService.getAllDemand();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureDemand,
      builder: (context, snapshot) {
        return (snapshot.hasData)
            ? ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  final demand = snapshot.data![index];
                  return DemandContainer(
                    demand: demand,
                  );
                })
            : Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                enabled: true,
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return PostShimmer();
                    }),
              );
      },
    );
  }
}
