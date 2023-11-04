import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/change_splash-screenn_provider.dart';
import '../size_config.dart';
import 'components/body.dart';

class SplashScreen extends StatelessWidget{
  static String  routeName = "splash";

  const SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      body:  ChangeNotifierProvider<ChangeSplashScreenProvider>(
          create: (BuildContext context) => ChangeSplashScreenProvider(),
          child: Body()
      ),
    );
  }
}