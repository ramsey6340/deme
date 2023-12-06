import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deme/models/financial_donation.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../models/organization.dart';
import '../../../../../services/shared_preferences_service.dart';
import '../../../../../widgets/donation_financial_container.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  late Stream<QuerySnapshot> assignmentStream;
  SharedPreferencesService sharedPreferencesService = SharedPreferencesService();
  String? organizationId = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initStream();
  }

  void initStream() async {
    Organization? currentOrganization = await sharedPreferencesService.getCurrentOrganization();
    organizationId = currentOrganization?.organizationId;
    assignmentStream = db.collection('donations')
        .where("organizationId", isEqualTo: organizationId)
        .where("amount", isGreaterThan:0)
        .snapshots();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: double.infinity,
      child: Expanded(
        child: StreamBuilder(
          stream: assignmentStream,
          builder: (context, snapshot) {
            return (snapshot.hasData)?
            GridView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final financialDonation = FinancialDonation.getFromSnapshotDoc(snapshot.data?.docs[index]);
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: DonationFinancialContainer(financialDonation: financialDonation,),
                  ),
                );
              },
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: 0.96,
              ),
            ):
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              enabled: true,
              child: ListView.builder(
                itemCount: 10,
                  itemBuilder: (context, index){
                return Container(
                  height: 100,
                  width: MediaQuery.sizeOf(context).width*0.8,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.grey
                  ),
                );
              })
            );
          },
        ),
      ),
    );
  }
}
