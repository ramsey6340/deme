import 'package:deme/constants.dart';
import 'package:deme/main-pages/home/body/campaign_page.dart';
import 'package:deme/provider/home_page_menu_option_provider.dart';
import 'package:deme/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

  List<Widget> homePages = [ActivityPage(), CampaignPage()];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: homePages.length,
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          centerTitle: true,
          title: Text('Accueil', style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w400), overflow: TextOverflow.ellipsis,),
          leading: IconButton(icon: Icon(Icons.account_circle_rounded), onPressed: (){},),
          actions: [
            IconButton(icon: Icon(Icons.map), onPressed: (){},),
          ],
          bottom: TabBar(
            labelColor: kPrimaryColor,
            dividerColor: Colors.grey,
            indicatorColor: kPrimaryColor,
            unselectedLabelColor: Colors.grey,
            indicator: UnderlineTabIndicator(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: kPrimaryColor, // Couleur noire avec opacité
                width: 3, // Largeur de la ligne de délimitation
              ),
            ),
            labelStyle: const TextStyle(
              backgroundColor: Colors.transparent, // Fond transparent pour le texte de l'onglet sélectionné
            ),
            unselectedLabelStyle: const TextStyle(
              backgroundColor: Colors.transparent, // Fond transparent pour le texte de l'onglet non sélectionné
            ),

            tabs: [
              Tab(icon: Text("Activités", style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, backgroundColor: Colors.transparent),)),
              Tab(icon: Text("Campagnes", style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold))),
            ],
          ),
        ),
        body: TabBarView(
          children: homePages,
        ),
      ),
    );
  }
}
