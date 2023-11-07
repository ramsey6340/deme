import 'package:deme/models/organization.dart';
import 'package:deme/widgets/profile_img.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../size_config.dart';

class OrganizationContainer extends StatefulWidget {
  const OrganizationContainer({super.key, required this.organization, this.showFollowButton=true, this.showNbFollower=true, this.onTapOrga});
  final Organization organization;
  final bool showFollowButton;
  final bool showNbFollower;
  final void Function()? onTapOrga;

  @override
  State<OrganizationContainer> createState() => _OrganizationContainerState();
}

class _OrganizationContainerState extends State<OrganizationContainer> {
  String formatNumber(int number) {
    final f = NumberFormat.compact(locale: 'en');
    return f.format(number);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTapOrga,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: getProportionateScreenWidth(10), horizontal: getProportionateScreenWidth(10)),
        margin: EdgeInsets.symmetric(vertical: getProportionateScreenWidth(5), horizontal: getProportionateScreenWidth(5)),
        decoration: BoxDecoration (
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileImg(
              profileImg: widget.organization.imageUrl,
              showIconAction: widget.organization.isVerified,
              iconMinimal: Icons.verified,
              iconMinimalColor: Colors.green,
              iconMinimalSize: 30,
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            widget.organization.name,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                                fontSize: 20,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                        (widget.showNbFollower)?Text(
                          '${formatNumber(widget.organization.nbSubscription)} suivies',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff676565)
                          ),
                        ):SizedBox(),
                      ],
                    ),
                  ),
                  (widget.showFollowButton)?Container(
                    width: double.infinity,
                    height: 34,
                    decoration: BoxDecoration (
                      border: Border.all(color: Color(0xff0077b5)),
                      color: Color(0xffffffff),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text(
                        'Suivre',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: kPrimaryColor
                        ),
                      ),
                    ),
                  ):SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
