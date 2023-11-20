import 'package:deme/main_screen.dart';
import 'package:deme/services/shared_preferences_service.dart';
import 'package:deme/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';

import '../log-pages/log-in/log_in.dart';

class LoadingSplashScreen extends StatefulWidget {
  const LoadingSplashScreen({super.key});

  @override
  State<LoadingSplashScreen> createState() => _LoadingSplashScreenState();
}

class _LoadingSplashScreenState extends State<LoadingSplashScreen> {
  SharedPreferencesService sharedPreferencesService = SharedPreferencesService();

  Future<Widget> futureCall() async {
    bool value = await sharedPreferencesService.getFirstInteraction() ?? true;

    if (value) {
      return SplashScreen();
    }
    else {
      String? typeUser = await sharedPreferencesService.getTypeUser();
      if(typeUser == null){
        return LogIn();
      }
      else {
        return MainScreen();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset(
          'assets/images/logo.jpg'),
      title: const Text(
        "Deme",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.grey.shade400,
      showLoader: true,
      loadingText: const Text("Loading..."),
      futureNavigator: futureCall(),
    );
  }
}
