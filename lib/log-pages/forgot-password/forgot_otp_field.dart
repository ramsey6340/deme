import 'package:async_button/async_button.dart';
import 'package:deme/constants.dart';
import 'package:deme/log-pages/forgot-password/reset_password.dart';
import 'package:deme/widgets/text_navigator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../provider/verification_otp_provider.dart';
import '../../size_config.dart';
import '../../utils.dart';
import '../../widgets/next_button.dart';

class ForgotOtpField extends StatefulWidget {
  static const String routeName = "forgot_otp_field";
  const ForgotOtpField({super.key});

  @override
  State<ForgotOtpField> createState() => _ForgotOtpFieldState();
}

class _ForgotOtpFieldState extends State<ForgotOtpField> {
  late FocusNode pin2FocusNode;
  late FocusNode pin3FocusNode;
  late FocusNode pin4FocusNode;
  AsyncBtnStatesController btnStateController = AsyncBtnStatesController();

  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  TextEditingController textEditingController3 = TextEditingController();
  TextEditingController textEditingController4 = TextEditingController();

  String otpProposedCode = '';


  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();

  }

  @override
  void dispose() {
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    super.dispose();
  }

  void nextField({required String value, required FocusNode focusNode}){
    if(value.length == 1){
      focusNode.requestFocus();
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final verificationOtpProvider = Provider.of<VerificationOtpProvider>(context);

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
                  height: getProportionateScreenHeight(300),
                  child: Image.asset(
                    'assets/images/forgot2.png',
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
                            Text("Entrer le code qui vous a été envoyé par SMS",
                              style: GoogleFonts.inter(fontWeight: FontWeight.w400),),
                            const SizedBox(height: 10,),
                            Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[

                                  TweenAnimationBuilder(
                                    tween: Tween(begin: 30.0, end: 0.0),
                                    duration: const Duration(seconds: 30),
                                    builder: (context, value, child) => Text(
                                      "00:${value.toInt()}",
                                      style: GoogleFonts.inter(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                        fontSize: 20
                                      ),),
                                    onEnd: (){},
                                  ),
                                  SizedBox(height: getProportionateScreenHeight(20)),
                                  otp_input(),
                                  Text(
                                    verificationOtpProvider.otpErrorMessage,
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  SizedBox(height: getProportionateScreenHeight(30)),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        7 * fem, 0 * fem, 0 * fem, 0 * fem),
                                    child: TextButton(
                                      onPressed: () {},
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                      ),
                                      child: Text('Envoyer un autre code',
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
                                  SizedBox(height: 10,),


                                  Center(
                                    child: AsyncTextBtn(
                                      style: kStyleNextBtn,

                                      asyncBtnStatesController: btnStateController,
                                      onPressed: () async {
                                        btnStateController.update(AsyncBtnState.loading);
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          otpProposedCode = textEditingController1.value.text.toString() +
                                              textEditingController2.value.text.toString() +
                                              textEditingController3.value.text.toString() +
                                              textEditingController4.value.text.toString();


                                          try {
                                            verificationOtpProvider.verificationOptCode(otpProposedCode);
                                            if(verificationOtpProvider.otpVerificationSuccessful){
                                              verificationOtpProvider.otpErrorMessage = '';
                                              print("Le code OTP est correct");
                                              Navigator.pushNamed(context, ResetPassword.routeName);
                                            }

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
                                  TextNavigator(onTap: (){Navigator.pop(context);}),
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


  // Methode qui va retourner un Widget Row contenant les 4 champ de saisi pour les 4 valeurs de la vérification par OTP
  Widget otp_input(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // La cellule 1 parmit les 4 cellules
        SizedBox(
          width: getProportionateScreenWidth(60),
          child: TextFormField(
            controller: textEditingController1,
            cursorColor: kTextColor,
            autofocus: true,
            keyboardType: TextInputType.number,
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
            decoration: otpFieldDecoration, // la decoration du cellule
            onChanged: (value){
              nextField(value: value, focusNode: pin2FocusNode);
            },
          ),
        ),
        // La cellule 2 parmit les 4 cellules
        SizedBox(
          width: getProportionateScreenWidth(60),
          child: TextFormField(
            controller: textEditingController2,
            cursorColor: kTextColor,
            focusNode: pin2FocusNode,
            keyboardType: TextInputType.number,
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
            decoration: otpFieldDecoration, // la decoration du cellule
            onChanged: (value){nextField(value: value, focusNode: pin3FocusNode);},
          ),
        ),
        // La cellule 3 parmit les 4 cellules
        SizedBox(
          width: getProportionateScreenWidth(60),
          child: TextFormField(
            controller: textEditingController3,
            cursorColor: kTextColor,
            focusNode: pin3FocusNode,
            keyboardType: TextInputType.number,
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
            decoration: otpFieldDecoration, // la decoration du cellule
            onChanged: (value){nextField(value: value, focusNode: pin4FocusNode);},
          ),
        ),
        // La cellule 4 parmit les 4 cellules
        SizedBox(
          width: getProportionateScreenWidth(60),
          child: TextFormField(
            controller: textEditingController4,
            cursorColor: kTextColor,
            focusNode: pin4FocusNode,
            keyboardType: TextInputType.number,
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
            decoration: otpFieldDecoration, // la decoration du cellule
            onChanged: (value){pin4FocusNode.unfocus();},
          ),
        ),
      ],
    );
  }
}
