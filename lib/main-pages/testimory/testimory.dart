import 'package:deme/main-pages/profile-page/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../data-test/data_test.dart';
import '../../provider/current_user_provider.dart';
import 'body/body.dart';
import '../../widgets/app_bar_custom.dart';

class Testimory extends StatelessWidget {
  const Testimory({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserProvider = Provider.of<CurrentUserProvider>(context);

    return Scaffold(
      appBar: AppBarCustom(
        title: 'Témoignages',
        onLeadingPress: () {
          if(currentUserProvider.profile == KTypeUser.organization){
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: ProfilePage(
                organization: currentUserProvider.currentOrganization!,),
              withNavBar: false, // OPTIONAL VALUE. True by default.
              pageTransitionAnimation: PageTransitionAnimation.fade,
            );
            /*Navigator.push(
                context, MaterialPageRoute(
                builder: (context)=>ProfilePage(
                  organization: currentUserProvider.currentOrganization!,)));*/
          }
        }, onTrailingPress: () {  },),
      body: Body(),
    );
  }
}
