import 'package:async_button/async_button.dart';
import 'package:deme/models/user.dart';
import 'package:deme/provider/change_log_screen_provider.dart';
import 'package:deme/widgets/text_navigator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../constants.dart';
import '../../../../../provider/current_user_provider.dart';
import '../../../../../provider/type_user_log_up_provider.dart';
import '../../../../../provider/verification_otp_provider.dart';
import '../../../../../services/auth_service.dart';
import '../../../../../size_config.dart';
import '../../../../../widgets/next_button.dart';

class OTPForm extends StatefulWidget {
  const OTPForm({Key? key}) : super(key: key);

  @override
  State<OTPForm> createState() => _OTPFormState();
}

class _OTPFormState extends State<OTPForm> {
  late FocusNode pin2FocusNode;
  late FocusNode pin3FocusNode;
  late FocusNode pin4FocusNode;

  AuthService authService = AuthService();

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

  void nextField({required String value, required FocusNode focusNode}) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  TextEditingController textEditingController3 = TextEditingController();
  TextEditingController textEditingController4 = TextEditingController();

  String otpProposedCode = '';

  AsyncBtnStatesController btnStateController = AsyncBtnStatesController();

  @override
  Widget build(BuildContext context) {
    final changeLogScreen = Provider.of<ChangeLogScreenProvider>(context);
    final verificationOtpProvider =
        Provider.of<VerificationOtpProvider>(context);
    final currentUserProvider = Provider.of<CurrentUserProvider>(context);

    final typeUserLogUpProvider = Provider.of<TypeUserLogUpProvider>(context);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Les 4 cellules pour le formulaire OTP
          otpInput(),
          Text(
            verificationOtpProvider.otpErrorMessage,
            style: TextStyle(color: Colors.red),
          ),
          SizedBox(
            height: getProportionateScreenHeight(50),
          ),

          // ========================Gestion du bouton asynchrone====================

          Center(
            child: AsyncTextBtn(
              style: kStyleNextBtn,

              asyncBtnStatesController: btnStateController,
              onPressed: () async {
                print("Profile: ${currentUserProvider.profile}");
                print("OTP dans App: ${verificationOtpProvider.trueOtpCode}");
                print("OTP proposé: $otpProposedCode");

                btnStateController.update(AsyncBtnState.loading);
                otpProposedCode = textEditingController1.value.text.toString() +
                    textEditingController2.value.text.toString() +
                    textEditingController3.value.text.toString() +
                    textEditingController4.value.text.toString();
                try {
                  verificationOtpProvider.verificationOptCode(otpProposedCode);
                  if (verificationOtpProvider.otpVerificationSuccessful) {
                    verificationOtpProvider.otpErrorMessage = '';
                    print("Le code OTP est correct");

                    if(currentUserProvider.profile == kTypeUser.user.toString()){
                      authService
                          .createUser(currentUserProvider.profile!, currentUserProvider.currentUserPassword!,
                          currentUserProvider.currentUser!)
                          .then((value) {
                        print("ID return : ${value}");
                        currentUserProvider.setUserId(value.toString());
                        print("Current User ID: ${currentUserProvider.currentUser?.userId}");
                        changeLogScreen.incrementIndex();
                        btnStateController.update(AsyncBtnState.success);
                      }).catchError((onError) {
                        print("Erreur: $onError");
                        btnStateController.update(AsyncBtnState.failure);
                      });
                    }
                    else if(currentUserProvider.profile == kTypeUser.organization.toString()){
                      authService
                          .createOrganization(currentUserProvider.profile!, currentUserProvider.currentUserPassword!,
                          currentUserProvider.currentOrganization!)
                          .then((value) {
                        currentUserProvider.setOrganizationId(value.toString());
                        changeLogScreen.incrementIndex();
                        btnStateController.update(AsyncBtnState.success);
                      }).catchError((onError) {
                        print("Erreur: $onError");
                        btnStateController.update(AsyncBtnState.failure);
                      });
                    }

                  } else {
                    print("Code OTP incorrect");
                    verificationOtpProvider.otpErrorMessage = "Code incorrecte";
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
                    Text('Success !',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)
                    )
                  ],
                ),
              ),
              failureStyle: AsyncBtnStateStyle(
                style: kStyleNextBtn,
                widget: const Row(
                  children: [
                    Icon(Icons.error, color: Colors.white,),
                    SizedBox(width: 4),
                    Text('Erreur !',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
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



          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          TextNavigator(onTap: () {
            changeLogScreen.decrementIndex();
          })
        ],
      ),
    );
  }

  // Methode qui va retourner un Widget Row contenant les 4 champ de saisi pour les 4 valeurs de la vérification par OTP
  Widget otpInput() {
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
            style: const TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
            decoration: otpFieldDecoration, // la decoration du cellule
            onChanged: (value) {
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
            style: const TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
            decoration: otpFieldDecoration, // la decoration du cellule
            onChanged: (value) {
              nextField(value: value, focusNode: pin3FocusNode);
            },
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
            style: const TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
            decoration: otpFieldDecoration, // la decoration du cellule
            onChanged: (value) {
              nextField(value: value, focusNode: pin4FocusNode);
            },
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
            style: const TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
            decoration: otpFieldDecoration, // la decoration du cellule
            onChanged: (value) {
              pin4FocusNode.unfocus();
            },
          ),
        ),
      ],
    );
  }
}
