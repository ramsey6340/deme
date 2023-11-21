import 'package:async_button/async_button.dart';
import 'package:deme/constants.dart';
import 'package:deme/log-pages/forgot-password/forgot_otp_field.dart';
import 'package:deme/provider/current_user_provider.dart';
import 'package:deme/services/auth_service.dart';
import 'package:deme/widgets/text_navigator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../provider/global_error_provider.dart';
import '../../provider/verification_otp_provider.dart';
import '../../services/organization_service.dart';
import '../../services/user_service.dart';
import '../../size_config.dart';
import '../../utils.dart';
import '../../widgets/next_button.dart';
import '../../widgets/phone_form_field_custom.dart';
import '../../widgets/text_form_field_custom.dart';

class ForgotEmailField extends StatefulWidget {
  static const String routeName = "forgot_phone_field";
  const ForgotEmailField({super.key});

  @override
  State<ForgotEmailField> createState() => _ForgotEmailFieldState();
}

class _ForgotEmailFieldState extends State<ForgotEmailField> {
  final _formKey = GlobalKey<FormState>();
  AsyncBtnStatesController btnStateController = AsyncBtnStatesController();
  TextEditingController emailController = TextEditingController();

  String? emailError;
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final globalErrorProvider = Provider.of<GlobalErrorProvider>(context);
    final verificationOtpProvider = Provider.of<VerificationOtpProvider>(context);
    final currentUserProvider = Provider.of<CurrentUserProvider>(context);


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
                            (globalErrorProvider.loginIdentityError != null)?Container(
                              child: Text(globalErrorProvider.loginIdentityError!,
                                style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ):SizedBox(),
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



                                  SizedBox(height: getProportionateScreenHeight(40)),

                                  Center(
                                    child: AsyncTextBtn(
                                      style: kStyleNextBtn,

                                      asyncBtnStatesController: btnStateController,
                                      onPressed: () async {
                                        btnStateController.update(AsyncBtnState.loading);
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          String email = emailController.value.text;

                                          try {
                                            authService.verifyEmailForResetPassword(email).then((value) {
                                              if(value != null){
                                                currentUserProvider.setResetUserPasswordId(value);
                                                authService.sendMailOtpCode(email).then((value) {
                                                  verificationOtpProvider.setTrueOtpCode(value);
                                                  Navigator.pushNamed(context, ForgotOtpField.routeName);
                                                  btnStateController.update(AsyncBtnState.success);

                                                }).catchError((onError){
                                                  print(onError);
                                                  btnStateController.update(AsyncBtnState.failure);
                                                });
                                              }
                                              else{
                                                btnStateController.update(AsyncBtnState.failure);
                                              }
                                            }).catchError((onError){
                                              print(onError);
                                              btnStateController.update(AsyncBtnState.failure);
                                            });
                                          } catch (e) {
                                            print(e);
                                            btnStateController.update(AsyncBtnState.failure);
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
