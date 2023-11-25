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
  late Future<List<Testimony>> futureTestimony;
  TestimonyService testimonyService = TestimonyService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureTestimony = testimonyService.getAllTestimony();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureTestimony,
      builder: (context, snapshot) {
        return (snapshot.hasData)
            ? ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  final testimony = snapshot.data![index];
                  return TestimonyContainer(
                    testimony: testimony,
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
