import 'package:flutter/material.dart';

import '../../widgets/app_bar_custom.dart';

class Testimory extends StatelessWidget {
  const Testimory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: 'Témoignages', onLeadingPress: () {  }, onTrailingPress: () {  },),
      body: Center(
        child: Text("Temognage"),
      ),
    );
  }
}
