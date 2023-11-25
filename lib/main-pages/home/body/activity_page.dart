import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../data-test/data_test.dart';
import '../../../models/post.dart';
import '../../../services/activity_service.dart';
import '../../../widgets/post_container.dart';
import '../../../widgets/post_shimmer.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  late Future<List<Post>> futurePosts;
  ActivityService postService = ActivityService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futurePosts = postService.getAllPost();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futurePosts,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                final post = snapshot.data![index];
                return PostContainer(
                  post: post,
                );
              });
        }
        else if(snapshot.hasError){
          return Center(
            child: Container(
              child: Image.asset("assets/images/404 error.jpg"),
            ),
          );
        }
        else {
          return Shimmer.fromColors(
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
        }
      },
    );
  }
}
