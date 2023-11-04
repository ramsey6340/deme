import 'package:deme/constants.dart';
import 'package:deme/main-pages/home/body/campaign_page.dart';
import 'package:deme/provider/home_page_menu_option_provider.dart';
import 'package:deme/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data-test/data_test.dart';
import '../../widgets/app_bar_custom.dart';
import '../../widgets/button_chip.dart';
import '../../widgets/post_container.dart';
import 'body/activity_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isActivitySelected = true;

  List<Widget> homePages = [ActivityPage(), CampaignPage()];
  @override
  Widget build(BuildContext context) {
    final homePageMenuOptionProvider = Provider.of<HomePageMenuOptionProvider>(context);
    return Scaffold(
      appBar: AppBarCustom(
        title: 'Accueil',
        onLeadingPress: () {},
        onTrailingPress: () {},
      ),
      body: Column(
        children: [
          PhysicalModel(
            elevation: 6, // Ajustez cette valeur pour contrôler l'élévation
            shadowColor: Colors.black, // Couleur de l'ombre
            color: Colors.white, // Couleur du conteneur

            child: SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.07,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonChip(press: () {
                    setState(() {
                      homePageMenuOptionProvider.setMenuOptionIndex(0);
                  });
                    }, text: 'Activités', isSelected: homePageMenuOptionProvider.menuOptionIndex==0),
                  SizedBox(width: getProportionateScreenWidth(20),),
                  ButtonChip(press: () {
                    setState(() {
                      homePageMenuOptionProvider.setMenuOptionIndex(1);
                  }); }, text: 'Campagnes', isSelected: homePageMenuOptionProvider.menuOptionIndex==1,),
                ],
              ),
            ),
          ),
          Expanded(child: homePages[homePageMenuOptionProvider.menuOptionIndex]),
        ],
      ),
    );
  }
}
