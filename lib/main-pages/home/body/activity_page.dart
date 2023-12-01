import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../data-test/data_test.dart';
import '../../../models/organization.dart';
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
  //late Future<List<Post>> futurePosts;
  //late Stream<QuerySnapshot> postStream;
  ActivityService postService = ActivityService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Dans initState");
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
                  return PostContainer(post: post);
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
      ),
    );
  }


  /*
  Container(
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
                  debugPrint("LE POST : ");
                  final post = Post.getFromSnapshotDoc(snapshot.data?.docs[index]);
                  return PostContainer(post: post);
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
      ),
    )
   */

}
