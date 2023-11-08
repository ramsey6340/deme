import 'package:deme/constants.dart';
import 'package:deme/main-pages/given/body/financial_page.dart';
import 'package:deme/main-pages/given/body/material_page_given.dart';
import 'package:deme/models/organization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BodyGiven extends StatefulWidget {
  const BodyGiven({super.key, required this.organization});
  final Organization organization;

  @override
  State<BodyGiven> createState() => _BodyGivenState();
}

class _BodyGivenState extends State<BodyGiven> {
  List<Widget> givenPages = [FinancialPage(), MaterialPageGiven()];
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: givenPages.length,
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          centerTitle: true,
          title: Text(
            '${widget.organization.name}',
            style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w400),
            overflow: TextOverflow.ellipsis,
          ),
          bottom: TabBar(
            labelColor: kPrimaryColor,
            dividerColor: Colors.black.withOpacity(0.8),
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
              backgroundColor: Colors
                  .transparent, // Fond transparent pour le texte de l'onglet sélectionné
            ),
            unselectedLabelStyle: const TextStyle(
              backgroundColor: Colors
                  .transparent, // Fond transparent pour le texte de l'onglet non sélectionné
            ),
            tabs: [
              Tab(
                  icon: Text(
                "Financier",
                style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.transparent),
              )),
              Tab(
                  icon: Text("Materiel",
                      style: GoogleFonts.inter(
                          fontSize: 18, fontWeight: FontWeight.bold))),
            ],
          ),
        ),
        body: TabBarView(
          children: givenPages,
        ),
      ),
    );
  }
}
