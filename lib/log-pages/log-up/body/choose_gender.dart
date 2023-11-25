import 'package:async_button/async_button.dart';
import 'package:deme/provider/current_user_provider.dart';
import 'package:deme/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../models/user_model.dart';
import '../../../provider/change_log_screen_provider.dart';
import '../../../provider/type_user_log_up_provider.dart';
import '../../../size_config.dart';
import '../../../widgets/list_tile_radio_custom.dart';

class ChooseGender extends StatefulWidget {
  static const String routeName = "choose_gender";
  const ChooseGender({super.key});

  @override
  State<ChooseGender> createState() => _ChooseGenderState();
}

class _ChooseGenderState extends State<ChooseGender> {
  final _formKey = GlobalKey<FormState>();
  AsyncBtnStatesController btnStateController = AsyncBtnStatesController();
  UserService userService = UserService();

  String? currentValue;

  @override
  Widget build(BuildContext context) {
    final typeUserLogUp = Provider.of<TypeUserLogUpProvider>(context);
    final changeLogScreen = Provider.of<ChangeLogScreenProvider>(context);
    final currentUserProvider = Provider.of<CurrentUserProvider>(context);

    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 27 * fem),
              child: Text(
                'Êtes-vous un homme ou une femme ?',
                style: GoogleFonts.inter(
                    fontSize: 30 * ffem,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ListTileRadioCustom(
                          title: 'Homme',
                          radioValue: 'man',
                          radioGroupValue: currentValue,
                          radioOnChanged: (value) {
                            setState(() {
                              currentValue = 'man';
                            });
                            currentUserProvider.setGender(currentValue!);
                          },
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                        ListTileRadioCustom(
                          title: 'Femme',
                          radioValue: 'women',
                          radioGroupValue: currentValue,
                          radioOnChanged: (value) {
                            setState(() {
                              currentValue = 'women';
                            });
                            currentUserProvider.setGender(currentValue!);
                          },
                        ),
                        SizedBox(height: getProportionateScreenHeight(50)),
                        // ========================Gestion du bouton asynchrone====================

                        Center(
                          child: AsyncTextBtn(
                            style: kStyleNextBtn,

                            asyncBtnStatesController: btnStateController,
                            onPressed: () async {
                              btnStateController.update(AsyncBtnState.loading);

                              try {
                                if(typeUserLogUp.typeUserLogUp == KTypeUser.user){
                                  if(currentValue != null){
                                    currentUserProvider.setGender(currentValue!);
                                    UserModel? currentUser = currentUserProvider.currentUser;
                                    if(currentUser != null){
                                      userService.patchUserInfo(
                                          currentUser.userId!,
                                          {"gender": currentValue}
                                      ).then((value) {
                                        changeLogScreen.incrementIndex();
                                        btnStateController.update(AsyncBtnState.success);

                                      }).catchError((onError){
                                        print(onError);
                                        btnStateController.update(AsyncBtnState.failure);
                                      });
                                    }
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

                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
