import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants.dart';
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
  final _formKey = GlobalKey<FormState>();

  String? loginError;

  @override
  Widget build(BuildContext context) {
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
                              "Login",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold),
                            ),
                            TextFormFieldCustom(
                              textInputType: TextInputType.emailAddress,
                              hintText: '',
                              hintTextColor:
                                  Colors.black.withOpacity(kTextFieldOpacity),
                              cursorColor: kRoundedCategoryColor,
                              errorText: loginError,
                              // la méthode validator
                              validator: (value) {
                                if (!emailValidatorRegExp.hasMatch(value!)) {
                                  setState(() {
                                    loginError = 'Ce login existe déjà';
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
                        SizedBox(height: getProportionateScreenHeight(20)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Date de naissance",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold),
                            ),
                            TextFormFieldCustom(
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
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
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
