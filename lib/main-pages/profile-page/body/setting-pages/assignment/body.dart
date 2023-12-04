import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deme/constants.dart';
import 'package:deme/provider/current_user_provider.dart';
import 'package:deme/services/shared_preferences_service.dart';
import 'package:deme/widgets/assignment_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../models/assignment.dart';
import '../../../../../models/organization.dart';

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
    assignmentStream = db.collection('assignments')
        .where("organizationId", isEqualTo: organizationId).snapshots();
    setState(() {
    });
  }
  
  @override
  Widget build(BuildContext context) {


    //double fem = MediaQuery.of(context).size.width / baseWidth;
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
                final assignment = Assignment.getFromSnapshotDoc(snapshot.data?.docs[index]);
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: AssignmentCard(
                      assignment: assignment,
                      onTap: (){},
                    ),
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
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 80),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.grey
                        ),
                      ),
                    ],
                  );
                },
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 0.96,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
