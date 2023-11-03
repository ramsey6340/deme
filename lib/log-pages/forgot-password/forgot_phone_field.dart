import 'package:deme/constants.dart';
import 'package:deme/log-pages/forgot-password/forgot_otp_field.dart';
import 'package:deme/widgets/text_navigator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../size_config.dart';
import '../../utils.dart';
import '../../widgets/next_button.dart';
import '../../widgets/phone_form_field_custom.dart';

class ForgotPhoneField extends StatefulWidget {
  static const String routeName = "forgot_phone_field";
  const ForgotPhoneField({super.key});

  @override
  State<ForgotPhoneField> createState() => _ForgotPhoneFieldState();
}

class _ForgotPhoneFieldState extends State<ForgotPhoneField> {
  final _formKey = GlobalKey<FormState>();

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
                // Image de header
                Container(
                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
                  width: getProportionateScreenWidth(428),
                  height: getProportionateScreenHeight(402),
                  child: Image.asset(
                    'assets/images/forgot1.png',
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
                          'Mot de passe oublié',
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
                            Text("Entrer votre numéro e téléphone, on vous enverra un code par SMS",
                            style: GoogleFonts.inter(fontWeight: FontWeight.w400),),
                            SizedBox(height: 20,),
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
                                  SizedBox(height: getProportionateScreenHeight(40)),
                                  NextButton(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: getProportionateScreenWidth(100),
                                        vertical: getProportionateScreenHeight(10)),
                                    press: () {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();

                                        Navigator.pushNamed(context, ForgotOtpField.routeName);
                                      }
                                    },
                                  ),
                                  SizedBox(height: getProportionateScreenHeight(20)),
                                  TextNavigator(onTap: (){
                                    Navigator.pop(context);
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
