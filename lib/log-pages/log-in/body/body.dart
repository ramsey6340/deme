import 'package:async_button/async_button.dart';
import 'package:deme/log-pages/log-up/log_up.dart';
import 'package:deme/provider/current_user_provider.dart';
import 'package:deme/provider/type_user_log_up_provider.dart';
import 'package:deme/services/organization_service.dart';
import 'package:deme/services/shared_preferences_service.dart';
import 'package:deme/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../main_screen.dart';
import '../../../provider/change_log_screen_provider.dart';
import '../../../provider/global_error_provider.dart';
import '../../../size_config.dart';
import '../../../utils.dart';
import '../../../widgets/text_form_field_custom.dart';
import '../../forgot-password/forgot_email_field.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _Body1State();
}

class _Body1State extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  AsyncBtnStatesController btnStateController = AsyncBtnStatesController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? passwordError;
  String? emailError;
  String? confirmPasswordError;

  String password = '';
  String confirmPassword = '';

  UserService userService = UserService();
  OrganizationService organizationService = OrganizationService();
  SharedPreferencesService sharedPreferencesService = SharedPreferencesService();


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
                margin:
                EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 27 * fem),
                child: Text(
                  'Se connecté',
                  style: GoogleFonts.inter(
                      fontSize: 30 * ffem,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ),

            (globalErrorProvider.loginIdentityError != null)?Container(
                child: Text(globalErrorProvider.loginIdentityError!,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ):SizedBox(),

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
                                  globalErrorProvider.setLoginIdentityError(null);
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


                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Mot de passe",
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold),
                              ),
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
                                      passwordError = "Mot de passe incorrecte";
                                    });
                                    return passwordError;
                                  } else {
                                    password = value;
                                    return null;
                                  }
                                },
                                // la méthode onChanged
                                onChanged: (value) {
                                  globalErrorProvider.setLoginIdentityError(null);
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
                            ],
                          ),
                          SizedBox(height: getProportionateScreenHeight(10),),
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                7 * fem, 0 * fem, 0 * fem, 0 * fem),
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, ForgotEmailField.routeName);
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              child: Text('Mot de passe oublié',
                                style: SafeGoogleFont(
                                  'Inter',
                                  fontSize: 16 * ffem,
                                  fontWeight: FontWeight.w500,
                                  height: 1.2125 * ffem / fem,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(20)),

                          // ========================Gestion du bouton asynchrone====================

                          Center(
                            child: AsyncTextBtn(
                              style: kStyleNextBtn,

                              asyncBtnStatesController: btnStateController,
                              onPressed: () async {
                                btnStateController.update(AsyncBtnState.loading);
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();

                                  String email = emailController.value.text;
                                  String password = passwordController.value.text;

                                  try {
                                    FirebaseAuth.instance.signInWithEmailAndPassword(
                                        email: email,
                                        password: password
                                    ).then((value) {
                                      if(value.user?.displayName == KTypeUser.user){
                                        userService.getUserById(value.user!.uid).then((value) {
                                          // Donnée en cache
                                          sharedPreferencesService.setCurrentUser(value);
                                          sharedPreferencesService.setTypeUser(KTypeUser.user);
                                          sharedPreferencesService.setFirstInteraction(false);

                                          // Donnée du provider
                                          currentUserProvider.setCurrentUser(value);
                                          /* On remet à null les données de l'utilisateur de type Organization */
                                          sharedPreferencesService.setCurrentOrganization(null);
                                          currentUserProvider.setCurrentOrganization(null);

                                          // Navigation vers la page d'accueil
                                          Navigator.pushNamedAndRemoveUntil(context, MainScreen.routeName, (route) => false);

                                        }).catchError((onError){
                                          print(onError);
                                          globalErrorProvider.setLoginIdentityError(kLoginMessageError);
                                          btnStateController.update(AsyncBtnState.failure);
                                        });
                                      }
                                      else if(value.user?.displayName == KTypeUser.organization){
                                        organizationService.getOrganizationById(value.user!.uid).then((value) {
                                          // Donnée en cache
                                          sharedPreferencesService.setCurrentOrganization(value);
                                          sharedPreferencesService.setTypeUser(KTypeUser.organization);
                                          sharedPreferencesService.setFirstInteraction(false);

                                          // Donnée du provider
                                          currentUserProvider.setCurrentOrganization(value);
                                          /* On remet à null les données de l'utilisateur de type User */
                                          sharedPreferencesService.setCurrentUser(null);
                                          currentUserProvider.setCurrentUser(null);

                                          // Navigation vers la page d'accueil
                                          Navigator.pushNamedAndRemoveUntil(context, MainScreen.routeName, (route) => false);

                                        }).catchError((onError){
                                          print(onError);
                                          globalErrorProvider.setLoginIdentityError(kLoginMessageError);
                                          btnStateController.update(AsyncBtnState.failure);
                                        });
                                      }
                                    }).catchError((onError){
                                      print(onError);
                                      globalErrorProvider.setLoginIdentityError(kLoginMessageError);
                                      btnStateController.update(AsyncBtnState.failure);
                                    });
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'user-not-found') {
                                      print('Cet utilisateur n\'existe pas');
                                      btnStateController.update(AsyncBtnState.failure);
                                    } else if (e.code == 'wrong-password') {
                                      print('Mauvais mot de passe fourni pour cet utilisateur.');
                                    }
                                  }
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
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                7 * fem, 0 * fem, 0 * fem, 0 * fem),
                            child: TextButton(
                              onPressed: () {
                                changeLogScreen.setIndex(0);
                                Navigator.pushNamed(context, LogUp.routeName);
                                typeUserLogUp.setTypeUserLogUp(null);
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
                                      text: 'Vous n’avez pas de compte ? ',
                                    ),
                                    TextSpan(
                                      text: 'S’inscrire',
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
    );
  }
}
