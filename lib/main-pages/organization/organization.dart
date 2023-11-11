import 'package:deme/main-pages/profile-page/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data-test/data_test.dart';
import '../../size_config.dart';
import '../../widgets/anim_search_widget_custom.dart';
import 'body/body.dart';
import '../../widgets/app_bar_custom.dart';

class Organization extends StatefulWidget {
  const Organization({super.key});

  @override
  State<Organization> createState() => _OrganizationState();
}

class _OrganizationState extends State<Organization> {

  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage(organization: organizations[0],)));
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
