import 'package:deme/main-pages/donation/donation.dart';
import 'package:deme/main-pages/given/given.dart';
import 'package:deme/main-pages/organization/organization.dart';
import 'package:deme/main-pages/testimory/testimory.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'main-pages/home/home.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = 'main_screen';
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  // La liste des différents bottom nav de l'appli Deme
  List<PersistentBottomNavBarItem> navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: FaIcon(FontAwesomeIcons.houseChimney),
        title: "Accueil",
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: const Color(0xFF676666).withOpacity(0.62),
      ),
      PersistentBottomNavBarItem(
        icon: FaIcon(FontAwesomeIcons.globe),
        title: ("Organisations"),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: const Color(0xFF676666).withOpacity(0.62),
      ),
      PersistentBottomNavBarItem(
        icon: FaIcon(FontAwesomeIcons.message),
        title: ("Témoignages"),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: const Color(0xFF676666).withOpacity(0.62),
      ),
      PersistentBottomNavBarItem(
        icon: FaIcon(FontAwesomeIcons.handshakeAngle),
        title: ("Démander"),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: const Color(0xFF676666).withOpacity(0.62),
      ),
      PersistentBottomNavBarItem(
        icon: FaIcon(FontAwesomeIcons.handHoldingHand),
        title: ("Donner"),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: const Color(0xFF676666).withOpacity(0.62),
      ),
    ];
  }

  PersistentTabController controller = PersistentTabController(initialIndex: 0);
  List<Widget> screens() {
    return [Home(), Organization(), Testimory(), Donation(), Given()];
  }



  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: controller,
      items: navBarItems(),
      backgroundColor: Colors.white,
      hideNavigationBarWhenKeyboardShows: true,
      popAllScreensOnTapOfSelectedTab: true,
      navBarStyle: NavBarStyle.style3,
      screens: screens(),
    );
  }
}
