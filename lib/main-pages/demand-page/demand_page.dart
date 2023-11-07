import 'package:flutter/material.dart';
import 'body/body.dart';
import '../../widgets/app_bar_custom.dart';

class DemandPage extends StatelessWidget {
  const DemandPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: 'Démandes',
        trailingIconData: Icons.add_box,
        onLeadingPress: () {  }, onTrailingPress: () {  },),
      body: Body(),
    );
  }
}
