import 'package:deme/models/financial_donation.dart';
import 'package:deme/services/financial_donation_service.dart';
import 'package:deme/widgets/financial_donation_widget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../widgets/financial_donation_widget_shimmer.dart';

class LastDonation extends StatefulWidget {
  const LastDonation({super.key});

  @override
  State<LastDonation> createState() => _LastDonationState();
}

class _LastDonationState extends State<LastDonation> {
  late Future<List<FinancialDonation>?> futureFinancialDonation;
  FinancialDonationService financialDonationService =
      FinancialDonationService();

  @override
  void initState() {
    super.initState();
    futureFinancialDonation =
        financialDonationService.getAllFinancialDonation();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: futureFinancialDonation,
        builder: (context, snapshot) {
          return (snapshot.hasData)
              ? ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    final financialDonation = snapshot.data![index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: FinancialDonationWidget(
                          financialDonation: financialDonation),
                    );
                  })
              : Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  enabled: true,
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Container(
                            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                            child: const FinancialDonationWidgetShimmer());
                      }),
                );
        },
      ),
    );
  }
}
