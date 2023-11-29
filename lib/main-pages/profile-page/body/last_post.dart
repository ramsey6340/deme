import 'package:deme/services/shared_preferences_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../models/post.dart';
import '../../../services/activity_service.dart';
import '../../../widgets/post_container.dart';
import '../../../widgets/post_shimmer.dart';

class LastPost extends StatefulWidget {
  const LastPost({super.key, required this.organizationId});
  final String organizationId;

  @override
  State<LastPost> createState() => _LastPostState();
}

class _LastPostState extends State<LastPost> {
  late Future<List<Post>?> futurePosts;
  ActivityService postService = ActivityService();

  @override
  void initState() {
    super.initState();
    futurePosts = postService.getAllPostsForOrganization(widget.organizationId);
    futurePosts.then((value) {
      print(value?.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: FutureBuilder(
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
    ));
  }
}
