import 'package:deme/main-pages/profile-page/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../data-test/data_test.dart';
import '../../provider/current_user_provider.dart';
import '../../size_config.dart';
import '../../widgets/anim_search_widget_custom.dart';
import 'body/body.dart';
import '../../widgets/app_bar_custom.dart';

class OrganizationPage extends StatefulWidget {
  const OrganizationPage({super.key});

  @override
  State<OrganizationPage> createState() => _OrganizationPageState();
}

class _OrganizationPageState extends State<OrganizationPage> {

  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final currentUserProvider = Provider.of<CurrentUserProvider>(context);


    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(
            color: Colors.black.withOpacity(0.5),
            height: 1,
          ),
        ),
        title: Text(
          'Organisation',
          style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w400),
          overflow: TextOverflow.ellipsis,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.account_circle_rounded,
            size: 30,
          ),
          onPressed: () {
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
          },
        ),
        actions: [
          AnimSearchWidgetCustom(
            boxShadow: false,
            color: Colors.transparent,
            textFieldColor: Colors.grey.withOpacity(0.5),
            helpText: 'Rechercher...',
            width: getProportionateScreenWidth(300),
            textController: textController,
            onSuffixTap: () {
              setState(() {
                textController.clear();
              });
            },
            onSubmitted: (value) {},
          ),
          SizedBox(width: 20,),
        ],
      ),
      body: Body(),
    );
  }
}
