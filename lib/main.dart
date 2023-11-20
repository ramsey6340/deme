import 'package:deme/provider/change_log_screen_provider.dart';
import 'package:deme/provider/current_user_provider.dart';
import 'package:deme/provider/global_error_provider.dart';
import 'package:deme/provider/type_user_log_up_provider.dart';
import 'package:deme/provider/verification_otp_provider.dart';
import 'package:deme/routes.dart';
import 'package:deme/size_config.dart';
import 'package:deme/splash/loading_splash_screen.dart';
import 'package:deme/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main_screen.dart';


void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TypeUserLogUpProvider()),
        ChangeNotifierProvider(create: (context) => ChangeLogScreenProvider()),
        ChangeNotifierProvider(create: (context) => VerificationOtpProvider()),
        ChangeNotifierProvider(create: (context) => CurrentUserProvider()),
        ChangeNotifierProvider(create: (context) => GlobalErrorProvider()),
      ],
    child: const MyApp(),
  ));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Deme',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: MainScreen(),
      home: LoadingSplashScreen(),
      routes: routes,
    );
  }
}