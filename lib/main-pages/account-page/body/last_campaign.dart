import 'package:flutter/material.dart';

class LastCampaign extends StatefulWidget {
  const LastCampaign({super.key});

  @override
  State<LastCampaign> createState() => _LastCampaignState();
}

class _LastCampaignState extends State<LastCampaign> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Center(child: Text("Campagnes"),));
  }
}
