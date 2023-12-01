import 'package:deme/constants.dart';
import 'package:deme/main-pages/profile-page/profile_page.dart';
import 'package:deme/provider/current_user_provider.dart';
import 'package:deme/widgets/organization_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../models/organization.dart';
import '../../provider/global_value.dart';
import '../../services/organization_service.dart';
import '../../size_config.dart';
import '../../widgets/anim_search_widget_custom.dart';
import '../../widgets/organization_shimmer.dart';
import 'body/give_to_organization/body_given.dart';

class Given extends StatefulWidget {
  static const routeName = "given_donation_page";
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
    final globalValue = Provider.of<GlobalValue>(context);
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
          'Faire un don',
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
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage(organization: currentUserProvider.currentOrganization!,)));
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
          const SizedBox(width: 20,),
        ],
      ),
      body: FutureBuilder(
        future: futureOrganization,
        builder: (context, snapshot) {
          return (snapshot.hasData)
              ? GridView.count(
                  childAspectRatio: 0.7,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: List.generate(
                      snapshot.data!.length,
                      (index) => OrganizationContainer(
                            organization: Future.value(snapshot.data![index]),
                            showFollowButton: false,
                            onTapOrga: () {
                              globalValue.setBeneficiaryDonation(BeneficiaryType.demand);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BodyGiven(
                                          organization:
                                              snapshot.data![index])));
                            },
                          )),
                )
              : Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  enabled: true,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 cartes par ligne
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio:
                          0.8, // Ajustez l'aspect ratio selon vos besoins
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
