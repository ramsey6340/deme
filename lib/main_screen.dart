import 'package:deme/constants.dart';
import 'package:deme/main-pages/given/given.dart';
import 'package:deme/main-pages/organization/organization_page.dart';
import 'package:deme/main-pages/testimory/testimory.dart';
import 'package:deme/provider/current_user_provider.dart';
import 'package:deme/provider/given_page_menu_option.dart';
import 'package:deme/provider/home_page_menu_option_provider.dart';
import 'package:deme/services/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import 'main-pages/demand-page/demand_page.dart';
import 'main-pages/home/home.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = 'main_screen';
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  SharedPreferencesService sharedPreferencesService = SharedPreferencesService();




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
        icon: FaIcon(FontAwesomeIcons.handHoldingHand),
        title: ("Démander"),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: const Color(0xFF676666).withOpacity(0.62),
      ),
      PersistentBottomNavBarItem(
        icon: FaIcon(FontAwesomeIcons.handshakeAngle),
        title: ("Donner"),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: const Color(0xFF676666).withOpacity(0.62),
      ),
    ];
  }

  PersistentTabController controller = PersistentTabController(initialIndex: 0);
  List<Widget> screens() {
    return [Home(), OrganizationPage(), Testimory(), DemandPage(), Given()];
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    final currentUserProvider = Provider.of<CurrentUserProvider>(context);
    sharedPreferencesService.getTypeUser().then((value) {
      if(value == KTypeUser.user){
        sharedPreferencesService.getCurrentUser().then((value) {
          currentUserProvider.setCurrentUser(value);
        }).catchError((onError){
          print(onError);
        });
      }
      else if(value == KTypeUser.organization){
        sharedPreferencesService.getCurrentOrganization().then((value) {
          currentUserProvider.setCurrentOrganization(value);
        }).catchError((onError){
          print(onError);
        });
      }
    });

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomePageMenuOptionProvider()),
        ChangeNotifierProvider(create: (context) => GivenPageMenuOptionProvider()),
      ],
      child: PersistentTabView(
        context,
        controller: controller,
        items: navBarItems(),
        backgroundColor: Colors.white,
        hideNavigationBarWhenKeyboardShows: true,
        popAllScreensOnTapOfSelectedTab: true,
        navBarStyle: NavBarStyle.style3,
        screens: screens(),
      ),
    );
  }
}
