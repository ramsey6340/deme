import 'package:deme/constants.dart';
import 'package:deme/models/organization.dart';
import 'package:deme/services/organization_service.dart';
import 'package:deme/size_config.dart';
import 'package:deme/widgets/organization_container.dart';
import 'package:intl/intl.dart';
import 'package:deme/widgets/profile_img.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../../data-test/data_test.dart';
import '../../../widgets/organization_shimmer.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Future<List<Organization>> futureOrganization;
  OrganizationService organizationService = OrganizationService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureOrganization = organizationService.getAllOrganizations();
  }

  String formatNumber(int number) {
    final f = NumberFormat.compact(locale: 'en');
    return f.format(number);
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureOrganization,
      builder: (context, snapshot) {
        return (snapshot.hasData)?
        GridView.count(
          childAspectRatio: 0.7,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          crossAxisSpacing: 0,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: List.generate(snapshot.data!.length, (index) => OrganizationContainer(organization: snapshot.data![index])),
        ):
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          enabled: true,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 cartes par ligne
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: 0.8, // Ajustez l'aspect ratio selon vos besoins
            ),
            itemBuilder: (context, index) {
              return OrganizationShimmer();
            },

          ),
        );
      },
    );
  }
}

