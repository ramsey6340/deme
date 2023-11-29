import 'package:deme/constants.dart';
import 'package:deme/main-pages/given/given.dart';
import 'package:deme/models/demand.dart';
import 'package:deme/models/organization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../provider/global_value.dart';
import 'financial_page_demand.dart';
import 'material_page_given_demand.dart';

class BodyGivenDemand extends StatefulWidget {
  const BodyGivenDemand({super.key, required this.demand});
  final Demand demand;

  @override
  State<BodyGivenDemand> createState() => _BodyGivenDemandState();
}

class _BodyGivenDemandState extends State<BodyGivenDemand> {
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final globalValue = Provider.of<GlobalValue>(context);

    return DefaultTabController(
      length: [
        FinancialPageDemand(demand: widget.demand),
        MaterialPageGivenDemand(demand: widget.demand)
      ].length,
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_outlined),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: (widget.demand.user != null)
              ? Text(
                  '${widget.demand.user?.login}-${widget.demand.cause.name}',
                  style: GoogleFonts.inter(
                      fontSize: 24, fontWeight: FontWeight.w400),
                  overflow: TextOverflow.ellipsis,
                )
              : Text(
                  '${widget.demand.organization?.login}-${widget.demand.cause.name}',
                  style: GoogleFonts.inter(
                      fontSize: 24, fontWeight: FontWeight.w400),
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
          children: [
            FinancialPageDemand(demand: widget.demand),
            MaterialPageGivenDemand(demand: widget.demand)
          ],
        ),
      ),
    );
  }
}
