import 'package:deme/main-pages/profile-page/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../data-test/data_test.dart';
import '../../provider/current_user_provider.dart';
import 'body/body.dart';
import '../../widgets/app_bar_custom.dart';

class DemandPage extends StatelessWidget {
  const DemandPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserProvider = Provider.of<CurrentUserProvider>(context);

    return Scaffold(
      appBar: AppBarCustom(
        title: 'Démandes',
        trailingIconData: Icons.add_box,
        onLeadingPress: () {
          if(currentUserProvider.profile == KTypeUser.organization){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage(organization: currentUserProvider.currentOrganization!,)));
          }
        },
        onTrailingPress: () {

        },
      ),
      body: Body(),
    );
  }
}
