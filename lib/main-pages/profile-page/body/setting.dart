import 'package:deme/size_config.dart';
import 'package:deme/widgets/next_page.dart';
import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    List<SettingData> settingData = [
      SettingData(
          icon: Icon(Icons.account_circle_rounded),
          title: 'Profile',
          routeName: 'setting_profile'),
      SettingData(
          icon: Icon(Icons.campaign_outlined),
          title: 'Activités',
          routeName: 'setting_activity'),
      SettingData(
          icon: Icon(Icons.campaign_outlined),
          title: 'Campagnes',
          routeName: 'setting_campaign'),
      SettingData(
          icon: Icon(Icons.campaign_outlined),
          title: 'Donations',
          routeName: 'setting_donation'),
      SettingData(
          icon: Icon(Icons.campaign_outlined),
          title: 'Demandes',
          routeName: 'setting_demand'),
      SettingData(
          icon: Icon(Icons.campaign_outlined),
          title: 'Notifications',
          routeName: 'setting_notification'),
      SettingData(
          icon: Icon(Icons.campaign_outlined),
          title: 'Sponsors',
          routeName: 'setting_sponsor'),
      SettingData(
          icon: Icon(Icons.campaign_outlined),
          title: 'Temoignages',
          routeName: 'setting_testimony'),
      SettingData(
          icon: Icon(Icons.campaign_outlined),
          title: 'Abonnements',
          routeName: 'setting_subscription'),
      SettingData(
          icon: Icon(Icons.campaign_outlined),
          title: 'Mode de paiement',
          routeName: 'setting_method_payment'),
    ];

    return SafeArea(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: ListView.builder(
            itemCount: settingData.length,
            itemBuilder: (context, index) {
              return Container(
                  margin: EdgeInsets.symmetric(
                      vertical: getProportionateScreenHeight(10)),
                  child: NextPage(
                      title: settingData[index].title,
                      press: () {
                        //Navigator.pushNamed(context, settingData[index].routeName);
                      },
                      leading: settingData[index].icon));
            }),
      ),
    );
  }
}

class SettingData {
  final Widget icon;
  final String title;
  final String routeName;

  SettingData(
      {required this.icon, required this.title, required this.routeName});
}
