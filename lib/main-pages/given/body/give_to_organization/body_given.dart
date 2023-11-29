import 'package:deme/constants.dart';
import 'package:deme/main-pages/given/given.dart';
import 'package:deme/models/demand.dart';
import 'package:deme/models/organization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../provider/global_value.dart';
import 'financial_page.dart';
import 'material_page_given.dart';


class BodyGiven extends StatefulWidget {
  const BodyGiven({super.key, required this.organization});
  final Organization organization;

  @override
  State<BodyGiven> createState() => _BodyGivenState();
}

class _BodyGivenState extends State<BodyGiven> {
  //List<Widget> givenPages = [FinancialPage(organization: widget.organization), MaterialPageGiven()];
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final globalValue = Provider.of<GlobalValue>(context);

    return DefaultTabController(
      length: [FinancialPage(organization: widget.organization), MaterialPageGiven(organization: widget.organization)].length,
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          centerTitle: true,
          leading: IconButton(icon: const Icon(Icons.arrow_back_outlined),
            onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Given()));
            }),
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
          children: [FinancialPage(organization: widget.organization), MaterialPageGiven(organization: widget.organization)],
        ),
      ),
    );
  }
}
