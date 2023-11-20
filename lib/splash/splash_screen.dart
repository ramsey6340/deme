import 'package:deme/services/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/change_splash-screenn_provider.dart';
import '../size_config.dart';
import 'components/body.dart';

class SplashScreen extends StatefulWidget{
  static String  routeName = "splash";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferencesService sharedPreferencesService = SharedPreferencesService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharedPreferencesService.setFirstInteraction(false);
  }

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