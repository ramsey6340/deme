import 'package:deme/constants.dart';
import 'package:deme/main-pages/profile-page/body/last_post.dart';
import 'package:deme/main-pages/profile-page/body/last_donation.dart';
import 'package:deme/main-pages/profile-page/body/setting.dart';
import 'package:deme/models/organization.dart';
import 'package:deme/size_config.dart';
import 'package:deme/widgets/profile_img.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.organization});

  final Organization organization;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Widget> accountPages = [Setting(), LastPost(), LastDonation()];

  String formatNumber(int number) {
    final f = NumberFormat.compact(locale: 'en');
    return f.format(number);
  }

  @override
  build(BuildContext context) {
    return DefaultTabController(
      length: accountPages.length,
      child: Scaffold(
        //appBar: AppBar(),
        body: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        width: double.infinity,
                        height: getProportionateScreenHeight(120),
                        decoration: const BoxDecoration(),
                        child: Image.asset(
                          'assets/data_test/profile_bgd.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back,
                                      color: Colors.black,
                                      size: 30,
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Stack(alignment: Alignment.center, children: [
                    Container(
                      width: double.infinity,
                      height: getProportionateScreenHeight(120),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: getProportionateScreenHeight(60),
                        ),
                        Text(
                          widget.organization.name,
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ]),
                ]),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  //margin: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 5),
                      shape: BoxShape.circle),
                  child: ProfileImg(
                    showIconAction: true,
                    iconMinimal: Icons.verified,
                    iconMinimalColor: Colors.green,
                    radiusSize: 60,
                    //profileImg: 'assets/data_test/avatar.png',
                    profileImg: widget.organization.imageUrl!,
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Text("@${widget.organization.login}",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                    )),
                const Divider(
                  color: Colors.black26,
                  indent: 50,
                  endIndent: 50,
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          formatNumber(
                              widget.organization.subscribersId.length),
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text(
                          "Abonnés",
                          style: GoogleFonts.inter(
                              color: Colors.black.withOpacity(0.8),
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          formatNumber(widget.organization.nbSubscription.toInt()),
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text(
                          "Abonnements",
                          style: GoogleFonts.inter(
                              color: Colors.black.withOpacity(0.8),
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "534",
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text(
                          "Activités",
                          style: GoogleFonts.inter(
                              color: Colors.black.withOpacity(0.8),
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.black26,
                  indent: 50,
                  endIndent: 50,
                  height: 30,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.4,
                        height: getProportionateScreenHeight(50),
                        decoration: BoxDecoration(
                          border: Border.all(color: kPrimaryColor),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: TextButton.icon(
                            onPressed: () {
                              setState(() {
                                if (widget.organization.subscribersId
                                    .contains(currentUserId)) {
                                  widget.organization.subscribersId
                                      .remove(currentUserId);
                                } else {
                                  widget.organization.subscribersId
                                      .add(currentUserId);
                                }
                              });
                            },
                            style: TextButton.styleFrom(
                                backgroundColor: widget
                                        .organization.subscribersId
                                        .contains(currentUserId)
                                    ? const Color(0xFF0077B5).withOpacity(0.3)
                                    : Colors.transparent),
                            icon: (widget.organization.subscribersId
                                    .contains(currentUserId))
                                ? const FaIcon(
                                    FontAwesomeIcons.userMinus,
                                    color: kPrimaryColor,
                                    size: 22,
                                  )
                                : const FaIcon(
                                    FontAwesomeIcons.userPlus,
                                    color: kPrimaryColor,
                                    size: 22,
                                  ),
                            label: Text(
                              (widget.organization.subscribersId
                                      .contains(currentUserId))
                                  ? "Suivi"
                                  : "Suivre",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor),
                            )),
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.4,
                        height: getProportionateScreenHeight(50),
                        decoration: BoxDecoration(
                          border: Border.all(color: kPrimaryColor),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: TextButton.icon(
                            onPressed: () {},
                            icon: const FaIcon(
                              FontAwesomeIcons.handshakeAngle,
                              color: kPrimaryColor,
                              size: 22,
                            ),
                            label: Text(
                              "Aider",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor),
                            )),
                      ),
                    ]),
              ],
            ),
          ),
          SliverPersistentHeader(
            delegate: _SliverAppBarDelegate(
              TabBar(
                labelColor: kPrimaryColor,
                indicatorColor: kPrimaryColor,
                labelStyle: GoogleFonts.inter(
                  fontWeight: FontWeight.bold
                ),
                tabs: const [
                  Tab(text: "Paramètres"),
                  Tab(text: "derniers post"),
                  Tab(text: "donations"),
                ],
              ),
            ),
            pinned: true,
          ),

          // SliverFillRemaining for the content
          SliverFillRemaining(
            child: TabBarView(
              children: accountPages,
            ),
          ),
        ]),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
