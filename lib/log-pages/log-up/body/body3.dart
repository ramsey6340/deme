import 'package:async_button/async_button.dart';
import 'package:deme/services/organization_service.dart';
import 'package:deme/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../provider/change_log_screen_provider.dart';
import '../../../provider/current_user_provider.dart';
import '../../../provider/global_error_provider.dart';
import '../../../provider/type_user_log_up_provider.dart';
import '../../../size_config.dart';
import '../../../utils.dart';
import '../../../widgets/next_button.dart';
import '../../../widgets/text_form_field_custom.dart';

class Body3 extends StatefulWidget {
  const Body3({super.key});

  @override
  State<Body3> createState() => _Body1State();
}

class _Body1State extends State<Body3> {
  UserService userService = UserService();
  OrganizationService organizationService = OrganizationService();

  TextEditingController birthDayController = TextEditingController();
  TextEditingController loginController = TextEditingController();

  AsyncBtnStatesController btnStateController = AsyncBtnStatesController();

  final _formKey = GlobalKey<FormState>();

  String? loginError;

  @override
  Widget build(BuildContext context) {
    final changeLogScreen = Provider.of<ChangeLogScreenProvider>(context);
    final typeUserLogUp = Provider.of<TypeUserLogUpProvider>(context);
    final currentUserProvider = Provider.of<CurrentUserProvider>(context);
    final globalErrorProvider = Provider.of<GlobalErrorProvider>(context);

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
                'Dite nous plus',
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nom d'utilisateur",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold),
                            ),
                            TextFormFieldCustom(
                              controller: loginController,
                              textInputType: TextInputType.emailAddress,
                              hintText: '',
                              hintTextColor:
                                  Colors.black.withOpacity(kTextFieldOpacity),
                              cursorColor: kRoundedCategoryColor,
                              errorText: loginError,
                              // la méthode validator
                              validator: (value) {
                                if (value!.isEmpty) {
                                  setState(() {
                                    loginError = 'Choisissez un login';
                                  });
                                  return loginError;
                                }
                                return null;
                              },
                              // la méthode onChanged
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  setState(() {
                                    loginError = '';
                                  });
                                } else if (value.isNotEmpty &&
                                    !emailValidatorRegExp.hasMatch(value)) {
                                  setState(() {
                                    loginError = '';
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                        (globalErrorProvider.loginAvailabilityError != null)
                            ? Text(
                                globalErrorProvider.loginAvailabilityError!,
                                style: GoogleFonts.inter(color: Colors.red),
                              )
                            : SizedBox(
                                height: getProportionateScreenHeight(20)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Date de naissance",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold),
                            ),
                            TextFormFieldCustom(
                              controller: birthDayController,
                              textInputType: TextInputType.datetime,
                              hintText: 'Date de naissance : JJ/MM/AAAA',
                              hintTextColor:
                                  Colors.black.withOpacity(kTextFieldOpacity),
                              cursorColor: kRoundedCategoryColor,
                              suffixColor: Colors.black,
                              inputTextColor: Colors.black,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Entrer votre date de naissance";
                                } else if (!birthDayRegExp.hasMatch(value)) {
                                  return "La date doit être de la forme JJ/MM/AAAA";
                                } else if (birthDayRegExp.hasMatch(value)) {
                                  final dateSplit = value.split("/");
                                  int day = int.parse(dateSplit[0]);
                                  int month = int.parse(dateSplit[1]);
                                  int year = int.parse(dateSplit[2]);
                                  final currentDate = DateTime.now();
                                  int currentYear = currentDate.year;
                                  int oldYear = currentYear - year;
                                  if (day < 1 || day > 31) {
                                    return "Le jour est incorrecte";
                                  } else if (month < 1 || month > 12) {
                                    return "Le mois est incorrecte";
                                  } else if (month >= 1 && month <= 12) {
                                    switch (month) {
                                      case 2:
                                        if (day > 29) {
                                          return "jour ou mois incorrecte";
                                        }
                                        break;
                                      case 4:
                                        if (day > 30) {
                                          return "jour ou mois incorrecte";
                                        }
                                        break;
                                      case 6:
                                        if (day > 30) {
                                          return "jour ou mois incorrecte";
                                        }
                                        break;
                                      case 9:
                                        if (day > 30) {
                                          return "jour ou mois incorrecte";
                                        }
                                        break;
                                      case 11:
                                        if (day > 30) {
                                          return "jour ou mois incorrecte";
                                        }
                                        break;
                                    }
                                  } else if (oldYear < 12) {
                                    return "Vous ête trop jeune";
                                  } else if (oldYear > 150) {
                                    return "Vous ête trop âgé";
                                  }
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(40),
                        ),

                        // ========================Gestion du bouton asynchrone====================

                        Center(
                          child: AsyncTextBtn(
                            style: kStyleNextBtn,

                            asyncBtnStatesController: btnStateController,
                            onPressed: () async {
                              btnStateController.update(AsyncBtnState.loading);

                              try {
                                if (currentUserProvider.profile == KTypeUser.user) {
                                  final currentUser =  currentUserProvider.currentUser;
                                  userService.isLoginAvailable(
                                      loginController.value.text)
                                      .then((value) {
                                    if (value) {
                                      globalErrorProvider
                                          .setLoginAvailabilityError(null);
                                      if (currentUser != null) {
                                        userService.patchUserInfo(
                                            currentUser.userId!, {
                                          "login": loginController.value.text,
                                          "birthDay":
                                          birthDayController.value.text
                                        }).then((value) {
                                          currentUserProvider.setLogin(
                                              value!.login.toString());
                                          currentUserProvider.setBirthDay(
                                              value.birthDay.toString());

                                          changeLogScreen.incrementIndex();

                                          btnStateController.update(AsyncBtnState.success);

                                        }).catchError((onError) {
                                          print(onError);
                                          btnStateController.update(AsyncBtnState.failure);
                                        });
                                      }
                                    } else {
                                      globalErrorProvider
                                          .setLoginAvailabilityError(
                                          "Ce nom d'utilisateur existe déjà");
                                    }
                                  }).catchError((onError) {
                                    print(onError);
                                    btnStateController.update(AsyncBtnState.failure);
                                  });
                                }

                                else if(currentUserProvider.profile == KTypeUser.organization){
                                  final currentOrganization =  currentUserProvider.currentOrganization;
                                  organizationService.isLoginAvailable(
                                      loginController.value.text)
                                      .then((value) {
                                    if (value) {
                                      globalErrorProvider
                                          .setLoginAvailabilityError(null);
                                      if (currentOrganization != null) {
                                        organizationService.patchOrganizationInfo(
                                            currentOrganization.organizationId!, {
                                          "login": loginController.value.text,
                                          "startDateExercise":
                                          birthDayController.value.text
                                        }).then((value) {
                                          currentUserProvider.setOrganizationLogin(
                                              value!.login.toString());
                                          currentUserProvider.setOrganizationStartDateExercise(
                                              value.startDateExercise.toString());

                                          changeLogScreen.twoCrementIndex();

                                          btnStateController.update(AsyncBtnState.success);

                                        }).catchError((onError) {
                                          print(onError);
                                          btnStateController.update(AsyncBtnState.failure);
                                        });
                                      }
                                    } else {
                                      globalErrorProvider
                                          .setLoginAvailabilityError(
                                          "Ce nom d'utilisateur existe déjà");
                                    }
                                  }).catchError((onError) {
                                    print(onError);
                                    btnStateController.update(AsyncBtnState.failure);
                                  });
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
                        GestureDetector(
                          onTap: () {
                            changeLogScreen.decrementIndex();
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 2 * fem, 0 * fem, 0 * fem),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.arrow_back),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Retour',
                                  style: SafeGoogleFont(
                                    'Inter',
                                    fontSize: 16 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.2125 * ffem / fem,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
