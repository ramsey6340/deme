import 'package:deme/main-pages/profile-page/body/setting-pages/assignment/list_assignment.dart';
import 'package:deme/main-pages/profile-page/body/setting-pages/assignment/setting_assignment.dart';
import 'package:deme/size_config.dart';
import 'package:deme/widgets/next_page.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    List<SettingData> settingDatas = [
      SettingData(
          icon: const Icon(Icons.account_circle_rounded),
          title: 'Profile',
          page: Text('setting_profile')
      ),
      SettingData(
          icon: const Icon(Icons.campaign_outlined),
          title: 'Mission',
          page: SettingAssignment(),
      ),
      SettingData(
          icon: const Icon(Icons.campaign_outlined),
          title: 'Activités',
          page: const Text('setting_profile')),
      SettingData(
          icon: const Icon(Icons.campaign_outlined),
          title: 'Campagnes',
          page: Text('setting_profile')
      ),
      SettingData(
          icon: Icon(Icons.campaign_outlined),
          title: 'Donations',
          page: Text('setting_profile')),
      SettingData(
          icon: Icon(Icons.campaign_outlined),
          title: 'Demandes',
          page: Text('setting_profile')),
      SettingData(
          icon: Icon(Icons.campaign_outlined),
          title: 'Notifications',
          page: Text('setting_profile')),
      SettingData(
          icon: Icon(Icons.campaign_outlined),
          title: 'Sponsors',
          page: Text('setting_profile')),
      SettingData(
          icon: Icon(Icons.campaign_outlined),
          title: 'Temoignages',
          page: Text('setting_profile')),
      SettingData(
          icon: Icon(Icons.campaign_outlined),
          title: 'Abonnements',
          page: Text('setting_profile')),
      SettingData(
          icon: Icon(Icons.campaign_outlined),
          title: 'Mode de paiement',
          page: Text('setting_profile')),
    ];

    return SafeArea(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: ListView.builder(
            itemCount: settingDatas.length,
            itemBuilder: (context, index) {
              return Container(
                  margin: EdgeInsets.symmetric(
                      vertical: getProportionateScreenHeight(10)),
                  child: NextPage(
                      title: settingDatas[index].title,
                      press: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: const ListAssignment(),
                          withNavBar: false, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );

                        /*Navigator.push(context, MaterialPageRoute(
                            builder: (context) => SettingAssignment()));*/
                      },
                      leading: settingDatas[index].icon));
            }),
      ),
    );
  }
}

class SettingData {
  final Widget icon;
  final String title;
  final Widget page;

  SettingData(
      {required this.icon, required this.title, required this.page});
}
