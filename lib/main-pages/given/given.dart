import 'package:deme/constants.dart';
import 'package:deme/main-pages/given/body/body_given.dart';
import 'package:deme/main-pages/given/body/financial_page.dart';
import 'package:deme/main-pages/given/body/material_page_given.dart';
import 'package:deme/widgets/organization_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import '../../models/organization.dart';
import '../../services/organization_service.dart';
import '../../size_config.dart';
import '../../widgets/anim_search_widget_custom.dart';
import '../../widgets/organization_shimmer.dart';
import '../../widgets/profile_img.dart';

class Given extends StatefulWidget {
  const Given({super.key});

  @override
  State<Given> createState() => _GivenState();
}

class _GivenState extends State<Given> {
  late Future<List<Organization>> futureOrganization;
  OrganizationService organizationService = OrganizationService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureOrganization = organizationService.getAllOrganizations();
  }

  String formatNumber(int number) {
    final f = NumberFormat.compact(locale: 'en');
    return f.format(number);
  }

  TextEditingController textController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(color: Colors.black.withOpacity(0.5), height: 1,),
        ),
        title: Text('Faire un don', style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w400), overflow: TextOverflow.ellipsis,),
        leading: IconButton(icon: Icon(Icons.account_circle_rounded, size: 30,), onPressed: (){},),
        actions: [
          AnimSearchWidgetCustom(
            boxShadow: false,
            color: Colors.transparent,
            textFieldColor: Colors.grey.withOpacity(0.5),
            helpText: 'Rechercher...',
            width: getProportionateScreenWidth(280),
            textController: textController,
            onSuffixTap: () {
              setState(() {
                textController.clear();
              });
            }, onSubmitted: (value) {  },
          ),

          IconButton(icon: Icon(Icons.map,), onPressed: (){},),
        ],
      ),
      body: FutureBuilder(
        future: futureOrganization,
        builder: (context, snapshot) {
          return (snapshot.hasData)?
          GridView.count(
            childAspectRatio: 0.8,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            crossAxisSpacing: 0,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: List.generate(snapshot.data!.length, (index) => OrganizationContainer(organization: snapshot.data![index], showFollowButton: false, onTapOrga: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => BodyGiven(organization: snapshot.data![index])));
            },)),
          ):
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            enabled: true,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 cartes par ligne
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: 0.8, // Ajustez l'aspect ratio selon vos besoins
              ),
              itemBuilder: (context, index) {
                return OrganizationShimmer();
              },

            ),
          );
        },
      ),
    );
  }
}
