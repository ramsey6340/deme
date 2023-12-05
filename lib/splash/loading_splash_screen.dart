import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deme/constants.dart';
import 'package:deme/main_screen.dart';
import 'package:deme/models/organization.dart';
import 'package:deme/models/user_model.dart';
import 'package:deme/services/activity_service.dart';
import 'package:deme/services/shared_preferences_service.dart';
import 'package:deme/splash/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:provider/provider.dart';

import '../log-pages/log-in/log_in.dart';
import '../models/cause.dart';
import '../provider/current_user_provider.dart';
import '../services/cause_service.dart';

class LoadingSplashScreen extends StatefulWidget {
  const LoadingSplashScreen({super.key});

  @override
  State<LoadingSplashScreen> createState() => _LoadingSplashScreenState();
}

class _LoadingSplashScreenState extends State<LoadingSplashScreen> {
  SharedPreferencesService sharedPreferencesService = SharedPreferencesService();

  ActivityService activityService = ActivityService();

  CauseService causeService = CauseService();
  late Future<List<Cause>> futureCause;

  @override
  void initState() {
    super.initState();

    sharedPreferencesService.setTypeUser(KTypeUser.organization);
    sharedPreferencesService.setFirstInteraction(false);
    Organization organization = Organization(
        organizationId: "EPf4LcCkOAVIjg93KQURq1H05FC3",
        name: "Fonds des Nations unies pour l'enfance",
        email: "drissasidiki7219@gmail.com",
        numTel: "+223 72196636",
        login: "UNICEF",
        imageUrl: "https://firebasestorage.googleapis.com/v0/b/deme-2bed9.appspot.com/o/profiles%2Forganizations%2Funicef.jpg?alt=media&token=b45465ee-a564-4c6b-9d8e-3b9969e86342",
        deviceType: "Android",
        deleted: false,
        activated: true,
        anonymous: false,
        profile: "organization",
        valid: true,
        verified: true,
        matricule: "ERTYUIDFGHJK",
        type: "Association",
        startDateExercise: "2000-02-10",
        nbSubscription: 0,
        address: null,
        subscribersId: [],
        preferredPaymentMethods: ["DxURAfDD1KkljA0BRqxC", "Irg1kDMRv55EqU16N1Af"],
        favoriteHumanitarianCauses: ["5mVQJ5dMVQVNGOqBK6BG", "VY7avuNsfiVbF7OgV4uL"]);
    sharedPreferencesService.setCurrentOrganization(organization);

    /*sharedPreferencesService.setTypeUser('user');
    User user = User(userId: '', name: 'name',
        email: 'email', login: 'login', numTel: 'numTel', birthDay: 'birthDay',
        imageUrl: 'imageUrl', deviceType: 'deviceType',
        delete: false, activated: true, anonymous: true,
        preferredPaymentMethods: [], favoriteHumanitarianCauses: [], profile: 'profile');
    sharedPreferencesService.setCurrentUser(user);*/
  }

 /* void test() async{
    FirebaseFirestore db = FirebaseFirestore.instance;
    final d = await db.collection('test').doc("DjmT0J48kKIhoK5do7NP").get();
    final json = d.data() as Map<String, dynamic>;
    print("Splash Screen: ${json.runtimeType.toString()}");
    final f = db.collection('test').doc("DjmT0J48kKIhoK5do7NP").get().then((value) {
      value.data()?["field1"].get().then((value){
        print(Organization.getFromSnapshotDoc(value).toString());
      });
    });
  }*/

  Future<Widget> futureCall() async {
    bool value = await sharedPreferencesService.getFirstInteraction() ?? true;

    if (value) {
      return  Future.value(new SplashScreen());
    }
    else {
      FirebaseAuth.instance
          .authStateChanges()
          .listen((User? user) async {
        if (user != null) {
          String? typeUser = await sharedPreferencesService.getTypeUser();
          if(typeUser == null){
            //return Future.value(new LogIn());
            return Future.value(new MainScreen());
          }
          else {
            print("le else typeUser: $typeUser");
            return Future.value(new MainScreen());
          }
        }
        else{
          return Future.value(new MainScreen());
          //return Future.value(new LogIn());
        }
      });
      return Future.value(new MainScreen());
      //return Future.value(new LogIn());
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
