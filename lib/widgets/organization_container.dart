import 'package:deme/models/organization.dart';
import 'package:deme/widgets/profile_img.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../constants.dart';
import '../size_config.dart';


class OrganizationContainer extends StatefulWidget {
  const OrganizationContainer({
    super.key,
    required this.organization,
    this.showFollowButton=true,
    this.showNbFollower=true,
    this.onTapOrga,
    this.onTapFollowBtn
  });

  final Organization organization;
  final bool showFollowButton;
  final bool showNbFollower;
  final void Function()? onTapFollowBtn;
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
              profileImg: widget.organization.imageUrl!,
              showIconAction: widget.organization.verified,
              iconMinimal: Icons.verified,
              iconMinimalColor: Colors.green,
              iconMinimalSize: 30,
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
                        Text(
                          widget.organization.login!,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        (widget.showNbFollower)?Text(
                          '${formatNumber(widget.organization.nbSubscription.toInt())} suivies',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff676565)
                          ),
                        ):const SizedBox(),
                      ],
                    ),
                  ),
                  (widget.showFollowButton)?
                  InkWell(
                    onTap: (){
                      widget.onTapFollowBtn?.call();
                    },
                    child: Container(
                      width: double.infinity,
                      height: 34,
                      decoration: BoxDecoration (
                        border: (widget.organization.subscribersId.contains(currentUserId))?null:Border.all(color: const Color(0xff0077b5)),
                        color: (widget.organization.subscribersId.contains(currentUserId))?const Color(0xFF0077B5).withOpacity(0.3):Colors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          (widget.organization.subscribersId.contains(currentUserId))?'Suivie':'Suivre',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: kPrimaryColor
                          ),
                        ),
                      ),
                    ),
                  ):const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
