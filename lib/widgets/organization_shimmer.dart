import 'package:deme/widgets/profile_img.dart';
import 'package:deme/widgets/title_placeholder.dart';
import 'package:flutter/material.dart';

class OrganizationShimmer extends StatelessWidget {
  const OrganizationShimmer({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0x26000000)),
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3f000000),
            offset: Offset(0, 0),
            blurRadius: 1,
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 25,
          ),
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TitlePlaceholder(width: 100),
                      TitlePlaceholder(width: 100),
                    ],
                  ),
                ),
                TitlePlaceholder(width: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
