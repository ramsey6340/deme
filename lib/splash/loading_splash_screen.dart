import 'package:deme/main_screen.dart';
import 'package:deme/models/user.dart';
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

  @override
  void initState() {
    super.initState();

    sharedPreferencesService.setFirstInteraction(false);
    sharedPreferencesService.setTypeUser(null);
    /*sharedPreferencesService.setTypeUser('user');
    User user = User(userId: '', name: 'name',
        email: 'email', login: 'login', numTel: 'numTel', birthDay: 'birthDay',
        imageUrl: 'imageUrl', deviceType: 'deviceType',
        delete: false, activated: true, anonymous: true,
        preferredPaymentMethods: [], favoriteHumanitarianCauses: [], profile: 'profile');
    sharedPreferencesService.setCurrentUser(user);*/
  }

  Future<Widget> futureCall() async {
    bool value = await sharedPreferencesService.getFirstInteraction() ?? true;

    if (value) {
      return  Future.value(new SplashScreen());
    }
    else {
      String? typeUser = await sharedPreferencesService.getTypeUser();
      if(typeUser == null){
        return  Future.value(new LogIn());
      }
      else {
        print("le else typeUser: $typeUser");
        return Future.value(new MainScreen());
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
