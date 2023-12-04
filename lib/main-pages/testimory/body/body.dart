import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deme/models/testimony.dart';
import 'package:deme/services/testimony_service.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../widgets/post_shimmer.dart';
import '../../../widgets/testimony_container.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  //late Future<List<Testimony>> futureTestimony;
  //TestimonyService testimonyService = TestimonyService();
  FirebaseFirestore db = FirebaseFirestore.instance;
  late Stream<QuerySnapshot> testimonyStream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //futureTestimony = testimonyService.getAllTestimony();
    testimonyStream = db.collection('testimonies').snapshots();
  }

  @override
  Widget build(BuildContext context) {


    return StreamBuilder(
      stream: testimonyStream,
      builder: (context, snapshot) {
        return (snapshot.hasData)
            ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final testimony = Testimony.getFromSnapshotDoc(snapshot.data?.docs[index]);
                  return TestimonyContainer(
                    testimony: testimony,
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
