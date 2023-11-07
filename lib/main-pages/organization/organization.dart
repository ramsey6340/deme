import 'package:flutter/material.dart';
import 'body/body.dart';
import '../../widgets/app_bar_custom.dart';

class Organization extends StatelessWidget {
  const Organization({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: 'Oraganisation', onLeadingPress: () {  }, onTrailingPress: () {  },),
      body: Body(),
    );
  }
}
