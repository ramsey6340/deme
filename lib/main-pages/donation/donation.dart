import 'package:flutter/material.dart';

import '../../widgets/app_bar_custom.dart';

class Donation extends StatelessWidget {
  const Donation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: 'Démandes', onLeadingPress: () {  }, onTrailingPress: () {  },),
      body: Center(
        child: Text("Demande"),
      ),
    );
  }
}
