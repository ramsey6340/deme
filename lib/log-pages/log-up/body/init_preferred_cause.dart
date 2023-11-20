import 'package:async_button/async_button.dart';
import 'package:deme/models/cause.dart';
import 'package:deme/provider/change_log_screen_provider.dart';
import 'package:deme/provider/type_user_log_up_provider.dart';
import 'package:deme/services/cause_service.dart';
import 'package:deme/services/organization_service.dart';
import 'package:deme/services/shared_preferences_service.dart';
import 'package:deme/widgets/checkbox_list_title_custom.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants.dart';
import '../../../main_screen.dart';
import '../../../models/method_payment.dart';
import '../../../provider/current_user_provider.dart';
import '../../../services/user_service.dart';
import '../../../size_config.dart';
import '../../../utils.dart';
import '../../../widgets/cause_card.dart';
import '../../../widgets/next_button.dart';
import '../../../widgets/text_navigator.dart';

class InitPreferredCause extends StatefulWidget {
  const InitPreferredCause({super.key});

  @override
  State<InitPreferredCause> createState() => _Body4State();
}

class _Body4State extends State<InitPreferredCause> {
  AsyncBtnStatesController btnStateController = AsyncBtnStatesController();
  SharedPreferencesService currentUserSharedPreferences = SharedPreferencesService();
  List<bool> causesCheckboxValues = List.generate(4, (index) => false);

  late Future<List<Cause>> futureCause;
  UserService userService = UserService();
  OrganizationService organizationService = OrganizationService();
  CauseService causeService = CauseService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureCause = causeService.getAllCause();
  }
  @override
  Widget build(BuildContext context) {
    final changeLogScreen = Provider.of<ChangeLogScreenProvider>(context);
    final typeUserLogUp = Provider.of<TypeUserLogUpProvider>(context);
    final currentUserProvider = Provider.of<CurrentUserProvider>(context);

    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text((typeUserLogUp.typeUserLogUp == 'user')?
                'Quelle sont vos causes préferé ?':'Quelles sont les causes que vôtre organisation defend ?',
                style: GoogleFonts.inter(
                    fontSize: 30 * ffem,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: getProportionateScreenHeight(500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  Expanded(
                    child: FutureBuilder(
                      future: futureCause,
                      builder: (context, snapshot) {
                        return (snapshot.hasData)?
                        GridView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            final cause = snapshot.data![index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: CauseCard(
                                checkBoxValue: currentUserProvider.currentUser!.favoriteHumanitarianCauses.contains(cause.causeId),
                                cause: cause,
                                onChangedCheckBoxValue: (value) {
                                  setState(() {
                                    if(value==true){
                                      currentUserProvider.addCause(cause.causeId);
                                    }
                                    else if(value==false){
                                      currentUserProvider.removeCause(cause.causeId);
                                    }
                                  });
                                },
                              ),
                            );
                          },
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            childAspectRatio: 0.96,
                          ),
                        ):
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          enabled: true,
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 100, horizontal: 100),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),

                  // ========================Gestion du bouton asynchrone====================
                  Center(
                    child: AsyncTextBtn(
                      style: kStyleNextBtn,

                      asyncBtnStatesController: btnStateController,
                      onPressed: () async {
                        btnStateController.update(AsyncBtnState.loading);

                        try {
                          if(currentUserProvider.profile == kTypeUser.user.toString()){
                            final currentUser = currentUserProvider.currentUser;
                            if(currentUser != null){
                              userService.patchUserInfo(
                                  currentUser.userId!,
                                  {"favoriteHumanitarianCauses": currentUser.favoriteHumanitarianCauses}
                              ).then((value) {
                                // Enregistrement des données de l'utilisateur dans le cache
                                currentUserSharedPreferences.setCurrentUser(currentUserProvider.currentUser);

                                Navigator.pushNamedAndRemoveUntil(context, MainScreen.routeName, (route) => false);
                                btnStateController.update(AsyncBtnState.success);
                                print(currentUserProvider.currentUser.toString());
                              }).catchError((onError){
                                print(onError);
                                btnStateController.update(AsyncBtnState.failure);
                              });
                            }
                          }

                          // S'il s'agit d'une organisation
                          if(currentUserProvider.profile == kTypeUser.organization.toString()) {
                            final currentOrganization = currentUserProvider.currentOrganization;
                            if(currentOrganization != null){
                              userService.patchUserInfo(
                                  currentOrganization.organizationId!,
                                  {"favoriteHumanitarianCauses": currentOrganization.favoriteHumanitarianCauses}
                              ).then((value) {
                                // Enregistrement des données de l'utilisateur dans le cache
                                currentUserSharedPreferences.setCurrentOrganization(currentUserProvider.currentOrganization);

                                Navigator.pushNamedAndRemoveUntil(context, MainScreen.routeName, (route) => false);
                                btnStateController.update(AsyncBtnState.success);
                                print(currentUserProvider.currentOrganization.toString());
                              }).catchError((onError){
                                print(onError);
                                btnStateController.update(AsyncBtnState.failure);
                              });
                            }
                          }

                        } catch (e) {
                          btnStateController.update(AsyncBtnState.failure);
                        }
                      },

                      loadingStyle: AsyncBtnStateStyle(
                        style: kStyleNextBtn,
                        widget: const SizedBox.square(
                          dimension: 30,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ),

                      successStyle: AsyncBtnStateStyle(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          foregroundColor: Colors.white,
                        ),
                        widget: const Row(
                          children: [
                            Icon(Icons.check, color: Colors.white,),
                            SizedBox(width: 4),
                            Text('Success!',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)
                            )
                          ],
                        ),
                      ),
                      failureStyle: AsyncBtnStateStyle(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        widget: const Row(
                          children: [
                            Icon(Icons.error, color: Colors.white,),
                            SizedBox(width: 4),
                            Text('Erreur !',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)
                            ),
                          ],
                        ),
                      ),
                      child: const Text(
                          'Continuer',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)
                      ),
                    ),
                  ),
                  // ========================Fin de la gestion du bouton asynchrone====================


                  SizedBox(height: getProportionateScreenHeight(20)),
                  TextNavigator(
                    onTap: () {
                      changeLogScreen.decrementIndex();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
