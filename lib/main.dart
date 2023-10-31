import 'package:deme/provider/change_splash-screenn.dart';
import 'package:deme/routes.dart';
import 'package:deme/size_config.dart';
import 'package:deme/splash/splash_screen.dart';
import 'package:flutter/material.dart';

import 'log-pages/log-up/log_up.dart';

void main() {
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return MaterialApp(
      title: 'Deme',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LogUp(),
      //home: SplashScreen(),
      routes: routes,
    );
  }
}
