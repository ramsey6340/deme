import 'package:deme/models/post.dart';
import 'package:deme/services/post_service.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../data-test/data_test.dart';
import '../../../widgets/post_container.dart';
import '../../../widgets/post_shimmer.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Future<List<Post>?> futurePosts;
  PostService postService = PostService();

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
        return (snapshot.hasData)
            ? ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  final post = snapshot.data![index];
                  return PostContainer(
                    post: post,
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
