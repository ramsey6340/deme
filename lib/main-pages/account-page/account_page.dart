import 'package:deme/constants.dart';
import 'package:deme/main-pages/account-page/body/last_activity.dart';
import 'package:deme/main-pages/account-page/body/last_campaign.dart';
import 'package:deme/main-pages/account-page/body/setting.dart';
import 'package:deme/size_config.dart';
import 'package:deme/widgets/profile_img.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key, required this.profileId});

  final String profileId;

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  List<Widget> accountPages = [Setting(), LastActivity(), LastCampaign()];

  @override
  build(BuildContext context) {
    return DefaultTabController(
      length: accountPages.length,
      child: Scaffold(
        body: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(children: [
                  Container(
                    width: double.infinity,
                    height: getProportionateScreenHeight(120),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/data_test/profile_bgd.png'),
                          fit: BoxFit.fill),
                    ),
                    child: Image.asset('assets/data_test/profile_bgd.png'),
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
                          "Fonds des Nations unies pour les Enfants (UNICEF)",
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
                  child: const ProfileImg(
                    showIconAction: true,
                    iconMinimal: Icons.verified,
                    iconMinimalColor: Colors.green,
                    radiusSize: 60,
                    profileImg: 'assets/data_test/avatar.png',
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Text("@UNICEF",
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
                          "20k",
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
                          "103",
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
                            onPressed: () {},
                            icon: const FaIcon(
                              FontAwesomeIcons.userPlus,
                              color: kPrimaryColor,
                              size: 22,
                            ),
                            label: Text(
                              "S'abonner",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                  fontSize: 16,
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
              const TabBar(
                labelColor: kPrimaryColor,
                indicatorColor: kPrimaryColor,
                tabs: [
                  Tab(text: "Paramètres"),
                  Tab(text: "Activités"),
                  Tab(text: "Campagnes"),
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

