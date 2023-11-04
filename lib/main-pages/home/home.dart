import 'package:deme/constants.dart';
import 'package:deme/size_config.dart';
import 'package:flutter/material.dart';
import '../../data-test/data_test.dart';
import '../../widgets/app_bar_custom.dart';
import '../../widgets/button_chip.dart';
import '../../widgets/post_container.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isActivitySelected = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: 'Accueil',
        onLeadingPress: () {},
        onTrailingPress: () {},
      ),
      body: Column(
        children: [
          PhysicalModel(
            elevation: 6, // Ajustez cette valeur pour contrôler l'élévation
            shadowColor: Colors.black, // Couleur de l'ombre
            color: Colors.white, // Couleur du conteneur

            child: SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonChip(press: () {
                    setState(() {
                    isActivitySelected = true;
                  });
                    }, text: 'Activités', isSelected: isActivitySelected),
                  SizedBox(width: getProportionateScreenWidth(20),),
                  ButtonChip(press: () { setState(() {
                    isActivitySelected = false;
                  }); }, text: 'Campagnes', isSelected: !isActivitySelected,),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return PostContainer(post: posts[index],);
                }),
          ),
        ],
      ),
    );
  }
}
