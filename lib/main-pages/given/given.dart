import 'package:flutter/material.dart';

import '../../widgets/app_bar_custom.dart';

class Given extends StatelessWidget {
  const Given({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: 'Faire un don', onLeadingPress: () {  }, onTrailingPress: () {  },),
      body: Center(
        child: Text("Given"),
      ),
    );
  }
}
