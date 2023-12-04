import 'package:deme/main-pages/profile-page/body/setting-pages/assignment/setting_assignment.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'body.dart';

class ListAssignment extends StatelessWidget {
  const ListAssignment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Missions"),
        actions: [
          IconButton(
              onPressed: (){
                /*PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: SettingAssignment(),
                  withNavBar: false, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.fade,
                );*/
                
                Navigator.push(context, MaterialPageRoute(builder: (context) => SettingAssignment()));
              },
              icon: const Icon(Icons.add_box))
        ],
      ),
      body: Body(),

    );
  }
}
