import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deme/constants.dart';
import 'package:deme/main-pages/profile-page/profile_page.dart';
import 'package:deme/provider/current_user_provider.dart';
import 'package:deme/widgets/organization_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
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
  //late Future<List<Organization>> futureOrganization;
  //OrganizationService organizationService = OrganizationService();

  late Stream<QuerySnapshot> organizationStream;
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //futureOrganization = organizationService.getAllOrganizations();
    organizationStream = db.collection('organizations').snapshots();
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
          preferredSize: const Size.fromHeight(1),
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
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: ProfilePage(
                  organization: currentUserProvider.currentOrganization!,),
                withNavBar: false, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.fade,
              );
            }
            else{
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: ProfilePage(
                  organization: currentUserProvider.currentOrganization!,),
                withNavBar: false, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.fade,
              );
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
      body: StreamBuilder(
        stream: organizationStream,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return GridView.count(
              childAspectRatio: 0.8,
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 8),
              crossAxisSpacing: 0,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: List.generate(
                  snapshot.data!.docs.length,
                      (index) {
                    final organization = Organization.getFromSnapshotDoc(snapshot.data?.docs[index]);
                    return OrganizationContainer(
                      organization: organization,
                      showFollowButton: false,
                      onTapOrga: () {
                        globalValue.setBeneficiaryDonation(BeneficiaryType.demand);

                        organization.then((value) {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: BodyGiven(
                              organization: value,),
                            withNavBar: false, // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation: PageTransitionAnimation.fade,
                          );
                        });
                      },
                    );
                  }),
            );
          }
          else if(snapshot.hasError){
            return Center(
              child: Image.asset("assets/images/404 error.jpg"),
            );
          }
          else{
            return Shimmer.fromColors(
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
                  return const OrganizationShimmer();
                },
              ),
            );
          }
        },
      ),
    );
  }
}
/*

OrganizationContainer(
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
                          )
 */