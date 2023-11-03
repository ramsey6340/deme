import 'package:flutter/material.dart';
import '../../widgets/app_bar_custom.dart';
import '../../widgets/post_container.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: 'Accueil',
        onLeadingPress: () {},
        onTrailingPress: () {},
      ),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return PostContainer();
          }),
    );
  }
}
