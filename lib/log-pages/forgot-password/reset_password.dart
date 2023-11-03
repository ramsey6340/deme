import 'package:deme/constants.dart';
import 'package:deme/log-pages/log-in/log_in.dart';
import 'package:deme/widgets/text_navigator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../size_config.dart';
import '../../utils.dart';
import '../../widgets/next_button.dart';
import '../../widgets/phone_form_field_custom.dart';
import '../../widgets/text_form_field_custom.dart';

class ResetPassword extends StatefulWidget {
  static const String routeName = "reset_password";
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  String? passwordError;
  String? confirmPasswordError;

  String password = '';
  String confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration (
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: getProportionateScreenHeight(30),),
                Container(
                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
                  width: getProportionateScreenWidth(428),
                  height: getProportionateScreenHeight(300),
                  child: Image.asset(
                    'assets/images/forgot3.png',
                    fit: BoxFit.cover,
                  ),
                ),

                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 10 * fem),
                        child: Text(
                          'Reinitialisé mon mot de passe',
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
                                      Text("Nouveau Mot de passe", style: GoogleFonts.inter(
                                          fontWeight: FontWeight.bold)),
                                      TextFormFieldCustom(
                                        isPassword: true,
                                        hintText: '',
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
                                              passwordError = "Mot de passe faible";
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
                                    ],
                                  ),
                                  (passwordError == null)
                                      ? const SizedBox(
                                    height: 24,
                                  )
                                      : const SizedBox(),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Confirmation", style: GoogleFonts.inter(
                                          fontWeight: FontWeight.bold)),
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
                                    ],
                                  ),
                                  SizedBox(height: getProportionateScreenHeight(40)),
                                  NextButton(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: getProportionateScreenWidth(100),
                                        vertical: getProportionateScreenHeight(10)),
                                    press: () {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                        Navigator.pushNamed(context, LogIn.routeName);
                                      }
                                    },
                                  ),
                                  SizedBox(height: getProportionateScreenHeight(20)),
                                  TextNavigator(text: 'Annuler', onTap: (){
                                    Navigator.pushNamed(context, LogIn.routeName);
                                  }),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
