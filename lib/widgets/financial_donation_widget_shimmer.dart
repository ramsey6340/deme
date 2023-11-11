import 'package:deme/widgets/title_placeholder.dart';
import 'package:flutter/material.dart';

class FinancialDonationWidgetShimmer extends StatelessWidget {
  const FinancialDonationWidgetShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(13, 7, 13, 7),
      width: double.infinity,
      height: 98,
      decoration: BoxDecoration (
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3f000000),
            offset: Offset(0, 0),
            blurRadius: 2,
          ),
        ],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              TitlePlaceholder(width: 100,),
              TitlePlaceholder(width: 80,),
              TitlePlaceholder(width: 150,),
            ],
          ),
          TitlePlaceholder(width: 100)
        ],
      ),
    );
  }
}
