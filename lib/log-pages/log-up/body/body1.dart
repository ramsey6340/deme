import 'package:async_button/async_button.dart';
import 'package:deme/main-pages/organization/organization_page.dart';
import 'package:deme/models/user.dart';
import 'package:deme/models/organization.dart';
import 'package:deme/widgets/text_navigator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../provider/change_log_screen_provider.dart';
import '../../../provider/current_user_provider.dart';
import '../../../provider/type_user_log_up_provider.dart';
import '../../../provider/verification_otp_provider.dart';
import '../../../services/auth_service.dart';
import '../../../size_config.dart';
import '../../../utils.dart';
import '../../../widgets/text_form_field_custom.dart';
import '../../log-in/log_in.dart';

import 'dart:io' show Platform;

class Body1 extends StatefulWidget {
  const Body1({super.key});

  @override
  State<Body1> createState() => _Body1State();
}

class _Body1State extends State<Body1> {
  AuthService authService = AuthService();
  AsyncBtnStatesController btnStateController = AsyncBtnStatesController();

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? passwordError;
  String? nameError;
  String? emailError;
  String? confirmPasswordError;
  String? phoneNumberError;

  String password = '';
  String confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    final typeUserLogUp = Provider.of<TypeUserLogUpProvider>(context);
    final currentUserProvider = Provider.of<CurrentUserProvider>(context);
    final verificationOtpProvider = Provider.of<VerificationOtpProvider>(context);

    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SafeArea(
      child: Consumer<ChangeLogScreenProvider>(
        builder: (context, changeLogScreen, child) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 27 * fem),
                child: Text((typeUserLogUp.typeUserLogUp == 'user')?
                  'Créer un compte':'Créer un compte pour votre organisation',
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
                                "Nom complet",
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold),
                              ),
                              TextFormFieldCustom(
                                controller: nameController,
                                textInputType: TextInputType.text,
                                hintText: '',
                                hintTextColor:
                                Colors.black.withOpacity(kTextFieldOpacity),
                                cursorColor: kRoundedCategoryColor,
                                errorText: nameError,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    setState(() {
                                      nameError = 'renseigner votre nom complet';
                                    });
                                    return nameError;
                                  }
                                  return null;
                                },
                                // la méthode onChanged
                                onChanged: (value) {
                                  if (value.isEmpty) {
                                    setState(() {
                                      nameError = '';
                                    });
                                  } else if (value.isNotEmpty &&
                                      !emailValidatorRegExp.hasMatch(value)) {
                                    setState(() {
                                      nameError = '';
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                          (nameError == null)
                              ? const SizedBox(
                            height: 24,
                          )
                              : const SizedBox(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Email",
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold),
                              ),
                              TextFormFieldCustom(
                                controller: emailController,
                                textInputType: TextInputType.emailAddress,
                                hintText: 'Ex: test@gmail.com',
                                hintTextColor:
                                Colors.black.withOpacity(kTextFieldOpacity),
                                cursorColor: kRoundedCategoryColor,
                                errorText: emailError,
                                // la méthode validator
                                validator: (value) {
                                  if (!emailValidatorRegExp.hasMatch(value!)) {
                                    setState(() {
                                      emailError = 'Email incorrecte';
                                    });
                                    return emailError;
                                  }
                                  return null;
                                },
                                // la méthode onChanged
                                onChanged: (value) {
                                  if (value.isEmpty) {
                                    setState(() {
                                      emailError = '';
                                    });
                                  } else if (value.isNotEmpty &&
                                      !emailValidatorRegExp.hasMatch(value)) {
                                    setState(() {
                                      emailError = '';
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                          (emailError == null)
                              ? const SizedBox(
                            height: 24,
                          )
                              : const SizedBox(),
                          TextFormFieldCustom(
                            controller: passwordController,
                            isPassword: true,
                            hintText: 'Mot de passe',
                            hintTextColor:
                                Colors.black.withOpacity(kTextFieldOpacity),
                            cursorColor: kRoundedCategoryColor,
                            errorText: passwordError,
                            // la méthode validator
                            validator: (value) {
                              if (value!.isEmpty) {
                                setState(() {
                                  password = value;
                                  passwordError = "Entrer le mot de passe";
                                });
                                return passwordError;
                              } else if (value.isNotEmpty &&
                                  value.length < kPasswordMaxLength) {
                                setState(() {
                                  password = value;
                                  passwordError = "Le mot de passe doit être au minimum 6 caractères";
                                });
                                return passwordError;
                              } else {
                                password = value;
                                return null;
                              }
                            },
                            // la méthode onChanged
                            onChanged: (value) {
                              if (value.isEmpty) {
                                setState(() {
                                  passwordError = '';
                                });
                              } else if (value.isNotEmpty &&
                                  value.length < kPasswordMaxLength) {
                                setState(() {
                                  passwordError = '';
                                });
                              } else if (value.isNotEmpty &&
                                  value.length >= kPasswordMaxLength) {
                                setState(() {
                                  passwordError = '';
                                });
                              }
                            },
                          ),
                          (passwordError == null)
                              ? const SizedBox(
                                  height: 24,
                                )
                              : const SizedBox(),
                          TextFormFieldCustom(
                            isPassword: true,
                            hintText: 'Confirmation de mot de passe',
                            hintTextColor:
                                Colors.black.withOpacity(kTextFieldOpacity),
                            cursorColor: kRoundedCategoryColor,
                            errorText: confirmPasswordError,
                            // la méthode validator
                            validator: (value) {
                              if (value!.isEmpty) {
                                setState(() {
                                  confirmPassword = value;
                                  confirmPasswordError =
                                      "Entrer la confirmation du mot de passe";
                                });
                                return confirmPasswordError;
                              } else if (value.isNotEmpty &&
                                  value.length < kPasswordMaxLength) {
                                setState(() {
                                  confirmPassword = value;
                                  confirmPasswordError = "mot de passe faible";
                                });
                                return confirmPasswordError;
                              } else if (value != password) {
                                setState(() {
                                  confirmPassword = value;
                                  confirmPasswordError =
                                      "les mots de passes ne correspondent pas";
                                });
                                return confirmPasswordError;
                              } else {
                                confirmPassword = value;
                                return null;
                              }
                            },
                            // la méthode onChanged
                            onChanged: (value) {
                              if (value.isEmpty) {
                                setState(() {
                                  confirmPasswordError = '';
                                });
                              } else if (value.isNotEmpty &&
                                  value.length < kPasswordMaxLength) {
                                setState(() {
                                  confirmPasswordError = '';
                                });
                              } else if (value.isNotEmpty &&
                                  value.length >= kPasswordMaxLength) {
                                setState(() {
                                  confirmPasswordError = '';
                                });
                              }
                            },
                          ),
                          SizedBox(height: getProportionateScreenHeight(20)),

                          // ========================Gestion du bouton asynchrone====================

                          Center(
                            child: AsyncTextBtn(
                              style: kStyleNextBtn,

                              asyncBtnStatesController: btnStateController,
                              onPressed: () async {
                                btnStateController.update(AsyncBtnState.loading);
                                try {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    String name = nameController.value.text;
                                    String email = emailController.value.text;
                                    String password = passwordController.value.text;

                                    // S'il s'agit d'un utilisateur simple
                                    if(typeUserLogUp.typeUserLogUp == kTypeUser.user.toString()){
                                      User currentUser = User(
                                          userId: null,
                                          name: name,
                                          email: email,
                                          login: null,
                                          numTel: null,
                                          imageUrl: null,
                                          deviceType: (Platform.isAndroid)?'Android':'iOS',
                                          delete: false,
                                          activated: true,
                                          anonymous: false,
                                          birthDay: null,
                                          profile: 'user',
                                          preferredPaymentMethods: [],
                                          favoriteHumanitarianCauses: []
                                      );
                                      authService.sendMailOtpCode(email).then((value) {
                                        verificationOtpProvider.setTrueOtpCode(value);
                                        print("Value : $value");
                                        btnStateController.update(AsyncBtnState.success);

                                        currentUserProvider.setCurrentUser(currentUser);
                                        currentUserProvider.setProfile('user');
                                        currentUserProvider.setCurrentUserPassword(password);
                                        print("Debut, User: ${currentUserProvider.currentUser}");
                                        changeLogScreen.incrementIndex();
                                      }).catchError((onError){
                                        print(onError);
                                        btnStateController.update(AsyncBtnState.failure);
                                      });
                                    }

                                    // S'il s'agit d'une organisation
                                    else if(typeUserLogUp.typeUserLogUp == kTypeUser.organization.toString()){
                                      Organization currentOrganization = Organization(
                                          organizationId: null,
                                          name: name,
                                          email: email,
                                          numTel: null,
                                          login: null,
                                          imageUrl: null,
                                          deviceType: (Platform.isAndroid)?'Android':'iOS',
                                          delete: false,
                                          activated: true,
                                          anonymous: false,
                                          profile: kTypeUser.organization.toString(),
                                          valid: true,
                                          verified: false,
                                          matricule: null,
                                          type: 'Association',
                                          startDateExercise: null,
                                          nbSubscription: 0,
                                          address: null,
                                          subscribersId: [],
                                          preferredPaymentMethods: [],
                                          favoriteHumanitarianCauses: []);


                                      authService.sendMailOtpCode(email).then((value) {
                                        verificationOtpProvider.setTrueOtpCode(value);
                                        btnStateController.update(AsyncBtnState.success);
                                        currentUserProvider.setCurrentOrganization(currentOrganization);
                                        currentUserProvider.setProfile(kTypeUser.organization.toString());
                                        currentUserProvider.setCurrentUserPassword(password);
                                        print("Debut, Organisation: ${currentUserProvider.currentUser}");
                                        changeLogScreen.incrementIndex();
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
                          TextNavigator(onTap: (){
                            changeLogScreen.decrementIndex();
                            typeUserLogUp.setTypeUserLogUp(null);
                          }),
                          SizedBox(height: getProportionateScreenHeight(20)),
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                7 * fem, 0 * fem, 0 * fem, 0 * fem),
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, LogIn.routeName);
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              child: RichText(
                                text: TextSpan(
                                  style: SafeGoogleFont(
                                    'Inter',
                                    fontSize: 16 * ffem,
                                    fontWeight: FontWeight.w500,
                                    height: 1.2125 * ffem / fem,
                                    color: Color(0xff000000),
                                  ),
                                  children: [
                                    const TextSpan(
                                      text: 'Vous avez déjà un compte ? ',
                                    ),
                                    TextSpan(
                                      text: 'Se connecté',
                                      style: SafeGoogleFont(
                                        'Inter',
                                        fontSize: 16 * ffem,
                                        fontWeight: FontWeight.w500,
                                        height: 1.2125 * ffem / fem,
                                        color: Color(0xff0077b5),
                                      ),
                                    ),
                                  ],
                                ),
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
      ),
    );
  }
}
