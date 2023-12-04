import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deme/main-pages/profile-page/profile_page.dart';
import 'package:deme/models/organization.dart';
import 'package:deme/services/organization_service.dart';
import 'package:deme/widgets/button_chip.dart';
import 'package:deme/widgets/organization_container.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../widgets/organization_shimmer.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
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

  List<ButtonChipData> buttonChipData = [
    ButtonChipData(text: 'Toutes'),
    ButtonChipData(text: 'Verifiés'),
    ButtonChipData(text: 'Suivies'),
    ButtonChipData(text: 'Les plus actives'),
    ButtonChipData(text: 'Populaires'),
    ButtonChipData(text: 'Nouvelles'),
  ];

  int currentIndex = 0;

  void setIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(buttonChipData.length, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        child: ButtonChip(
                          selectedTextColor: const Color(0xFF0077B5),
                            selectedBackground: const Color(0xFF0077B5).withOpacity(0.3),
                            isSelected: index == currentIndex,
                            press: () {
                              setIndex(index);
                            },
                            text: buttonChipData[index].text),
                      );
                    }),
                  ),
                )),
          ),
          Expanded(
            child: StreamBuilder(
              stream: organizationStream,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return GridView.count(
                    childAspectRatio: 0.65,
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
                            onTapFollowBtn: (){

                            },
                            onTapOrga: () {
                              organization.then((value) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ProfilePage(
                                                organization:
                                                value)));
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
                        return OrganizationShimmer();
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonChipData {
  final String text;

  ButtonChipData({required this.text});
}
