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
                          selectedTextColor: Color(0xFF0077B5),
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
            child: FutureBuilder(
              future: futureOrganization,
              builder: (context, snapshot) {
                return (snapshot.hasData)
                    ? GridView.count(
                        childAspectRatio: 0.65,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 10,
                        crossAxisCount: 2,
                        children: List.generate(
                            snapshot.data!.length,
                            (index) => OrganizationContainer(
                                  organization: snapshot.data![index],
                                  onTapFollowBtn: (){
                                    setState(() {
                                      if(snapshot.data![index].subscribersId.contains('1')){
                                        snapshot.data![index].subscribersId.remove('1');
                                      }else{
                                        snapshot.data![index].subscribersId.add('1');
                                      }
                                    });
                                  },
                                  onTapOrga: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ProfilePage(
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
