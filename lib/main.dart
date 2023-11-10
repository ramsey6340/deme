import 'package:deme/provider/change_log_screen_provider.dart';
import 'package:deme/provider/change_splash-screenn_provider.dart';
import 'package:deme/provider/type_user_log_up_provider.dart';
import 'package:deme/routes.dart';
import 'package:deme/size_config.dart';
import 'package:deme/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'log-pages/forgot-password/forgot_otp_field.dart';
import 'log-pages/forgot-password/forgot_phone_field.dart';
import 'log-pages/forgot-password/reset_password.dart';
import 'log-pages/log-in/log_in.dart';
import 'log-pages/log-up/body/otp/otp_screen.dart';
import 'log-pages/log-up/log_up.dart';
import 'main-pages/account-page/account_page.dart';
import 'main_screen.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TypeUserLogUpProvider()),
        ChangeNotifierProvider(create: (context) => ChangeLogScreenProvider()),
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
      home: AccountPage(profileId: '1',),
      //home: MainScreen(),
      //home: SplashScreen(),
      routes: routes,
    );
  }
}