import 'package:deme/log-pages/log-up/log_up.dart';
import 'package:deme/provider/type_user_log_up.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../provider/change_log_screen.dart';
import '../../../size_config.dart';
import '../../../utils.dart';
import '../../../widgets/next_button.dart';
import '../../../widgets/phone_form_field_custom.dart';
import '../../../widgets/text_form_field_custom.dart';
import '../../forgot-password/forgot_phone_field.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _Body1State();
}

class _Body1State extends State<Body> {
  final _formKey = GlobalKey<FormState>();

  String? passwordError;
  String? emailError;
  String? confirmPasswordError;

  String password = '';
  String confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    final changeLogScreen = Provider.of<ChangeLogScreen>(context);
    final typeUserLogUp = Provider.of<TypeUserLogUp>(context);

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
                                "Numéro de téléphone",
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold),
                              ),
                              PhoneFormFieldCustom(
                                hintText: 'numéro de téléphone',
                                fillColor: Colors.white,
                                focusBorderSideColor: Colors.black,
                                borderSideColor: Colors.black,
                                hintTextColor:
                                Colors.black.withOpacity(kTextFieldOpacity),
                                cursorColor: kRoundedCategoryColor,
                                inputTextColor: Colors.black,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Email",
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold),
                              ),
                              TextFormFieldCustom(
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
                          SizedBox(height: getProportionateScreenHeight(10),),
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                7 * fem, 0 * fem, 0 * fem, 0 * fem),
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, ForgotPhoneField.routeName);
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
                          NextButton(
                            padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(100),
                                vertical: getProportionateScreenHeight(10)),
                            press: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                              }
                            },
                          ),
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
