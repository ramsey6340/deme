import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deme/provider/current_user_provider.dart';
import 'package:deme/services/shared_preferences_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  //late Future<List<Post>?> futurePosts;
  //ActivityService postService = ActivityService();

  @override
  void initState() {
    super.initState();
    print("Hello Last Post");
    //futurePosts = postService.getAllPostsForOrganization(widget.organizationId);
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final Stream<QuerySnapshot> postStream = db.collection('posts').snapshots();


    return Container(
      constraints: BoxConstraints(
          maxHeight: double.infinity,
          maxWidth: MediaQuery.sizeOf(context).width*0.9
      ),
      child: StreamBuilder(
        stream: postStream,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final post = Post.getFromSnapshotDoc(snapshot.data?.docs[index]);
                  post.then((value) {
                    print("${value.postId}");
                  });
                  return PostContainer(post: post);
                });
          }
          else if(snapshot.hasError){
            return Center(
              child: Image.asset("assets/images/404 error.jpg"),
            );
          }
          else {
            return Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              enabled: true,
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return PostShimmer();
                  }),
            );
          }
        },
      ),
    );
  }
}



/*
FutureBuilder(
      future: futurePosts,
      builder: (context, snapshot) {
        return (snapshot.hasData)
            ? ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  final post = snapshot.data![index];
                  return SizedBox();
                  /*
                  PostContainer(
                    post: post,
                  )
                   */
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
    )
 */
