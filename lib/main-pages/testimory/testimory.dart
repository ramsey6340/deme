import 'package:deme/main-pages/profile-page/profile_page.dart';
import 'package:flutter/material.dart';
import '../../data-test/data_test.dart';
import 'body/body.dart';
import '../../widgets/app_bar_custom.dart';

class Testimory extends StatelessWidget {
  const Testimory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: 'Témoignages',
        onLeadingPress: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage(organization: organizations[0],)));

        }, onTrailingPress: () {  },),
      body: Body(),
    );
  }
}
