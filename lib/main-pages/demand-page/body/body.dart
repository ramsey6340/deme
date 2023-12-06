import 'package:cloud_firestore/cloud_firestore.dart';
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
 // DonationService demandService = DonationService();
  FirebaseFirestore db = FirebaseFirestore.instance;
  late Stream<QuerySnapshot> demandStream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //futureDemand = demandService.getAllDemand();
    demandStream = db.collection('demands').orderBy("creationDate", descending:true).snapshots();

  }

  @override
  Widget build(BuildContext context) {
    //FirebaseFirestore db = FirebaseFirestore.instance;
    //final Stream<QuerySnapshot> demandStream = db.collection('demands').snapshots();
    return StreamBuilder(
      stream: demandStream,
      builder: (context, snapshot) {
        return (snapshot.hasData)
            ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final demand = Demand.getFromSnapshotDoc(snapshot.data?.docs[index]);
                  return DemandContainer(
                    demand: demand,
                  );
                })
            : Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                enabled: true,
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return const PostShimmer();
                    }),
              );
      },
    );
  }
}
