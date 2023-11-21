import 'package:async_button/async_button.dart';
import 'package:deme/models/organization.dart';
import 'package:deme/services/organization_service.dart';
import 'package:deme/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../models/user.dart';
import '../../../provider/change_log_screen_provider.dart';
import '../../../provider/current_user_provider.dart';
import '../../../provider/global_error_provider.dart';
import '../../../provider/type_user_log_up_provider.dart';
import '../../../size_config.dart';
import '../../../widgets/phone_form_field_custom.dart';
import '../../../widgets/profile_img.dart';
import '../../../widgets/text_form_field_custom.dart';

class Body2 extends StatefulWidget {
  const Body2({super.key});

  @override
  State<Body2> createState() => _Body1State();
}

class _Body1State extends State<Body2> {
  UserService userService = UserService();
  OrganizationService organizationService = OrganizationService();

  AsyncBtnStatesController btnStateController = AsyncBtnStatesController();


  final _formKey = GlobalKey<FormState>();

  String phoneNumberValue = '';
  String? passwordError;
  String? emailError;
  String? confirmPasswordError;
  String? phoneNumberError;

  String password = '';
  String confirmPassword = '';

  TextEditingController numTelController = TextEditingController();
  TextEditingController matriculeController = TextEditingController();

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
        margin: const EdgeInsets.only(left: 20, right: 20,  bottom: 20),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 27 * fem),
              child: Text((typeUserLogUp.typeUserLogUp == 'user')?
                'Dite nous plus':'Dite nous plus sur vôtre organisation',
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
                        ProfileImg(
                          profileImg: 'assets/data_test/avatar.png',
                          pressShowImg: () {},
                          showIconAction: true,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        PhoneFormFieldCustom(
                          controller: numTelController,
                          hintText: (typeUserLogUp.typeUserLogUp == 'user')?'numéro de téléphone':'numéro de téléphone de l\'organisation',
                          fillColor: Colors.white,
                          focusBorderSideColor: (phoneNumberError != null)?Colors.red:Colors.black,
                          borderSideColor: (phoneNumberError != null)?Colors.red:Colors.black,
                          hintTextColor: Colors.black.withOpacity(kTextFieldOpacity),
                          cursorColor: kRoundedCategoryColor,
                          inputTextColor: Colors.black,
                          errorBorderColor: (phoneNumberError != null)?Colors.red:Colors.black,
                          focusErrorBorderColor: (phoneNumberError != null)?Colors.red:Colors.black,
                          validator: (phoneNumber){
                            if (numTelController.value.text.isEmpty) {
                              return "Entrer un numéro de téléphone";
                            } else {
                              setState(() {
                                phoneNumberValue = '${phoneNumber!.countryCode} ${numTelController.value.text}';
                              });
                              return null;
                            }
                            return null; // La validation a réussi, pas d'erreur.
                          },
                          onChanged: (phoneNumber){
                            if (!phoneNumber.isValidNumber()) {
                              setState(() {
                                phoneNumberError = "Entrer un numéro de téléphone";
                              });
                            }
                          },
                        ),
                        (globalErrorProvider.numTelError!=null)?Text(globalErrorProvider.numTelError!, style: TextStyle(color: Colors.red),):const SizedBox(),
                        (typeUserLogUp.typeUserLogUp == KTypeUser.organization)? SizedBox(height: getProportionateScreenHeight(20)): SizedBox(),
                        (typeUserLogUp.typeUserLogUp == KTypeUser.organization)?
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Matricule de l'organisation",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold),
                            ),
                            TextFormFieldCustom(
                              controller: matriculeController,
                              textInputType: TextInputType.emailAddress,
                              hintText: 'Matricule',
                              hintTextColor: Colors.black.withOpacity(kTextFieldOpacity),
                              cursorColor: kRoundedCategoryColor,
                            ),
                          ],
                        ):SizedBox(),
                        SizedBox(height: getProportionateScreenHeight(30)),

                        // ========================Gestion du bouton asynchrone====================

                        Center(
                          child: AsyncTextBtn(
                            style: kStyleNextBtn,

                            asyncBtnStatesController: btnStateController,
                            onPressed: () async {
                              btnStateController.update(AsyncBtnState.loading);

                              try {
                                if(typeUserLogUp.typeUserLogUp == KTypeUser.user){
                                  if(numTelController.value.text.isNotEmpty){
                                    currentUserProvider.setNumTel(phoneNumberValue);
                                    User? currentUser = currentUserProvider.currentUser;
                                    if(currentUser != null){
                                      userService.patchUserInfo(
                                          currentUser.userId!,
                                          {"numTel": phoneNumberValue}
                                      ).then((value) {
                                        globalErrorProvider.setNumTelError(null);
                                        changeLogScreen.incrementIndex();
                                        btnStateController.update(AsyncBtnState.success);

                                      }).catchError((onError){
                                        print(onError);
                                        btnStateController.update(AsyncBtnState.failure);
                                      });
                                    }
                                  }
                                  else{
                                    globalErrorProvider.setNumTelError("Numero de téléphone incorrcte");
                                  }
                                }

                                else if(currentUserProvider.profile == KTypeUser.organization) {
                                  if(numTelController.value.text.isNotEmpty && matriculeController.value.text.isNotEmpty){
                                    currentUserProvider.setOrganizationMatricule(matriculeController.value.text);
                                    currentUserProvider.setOrganizationNumTel(phoneNumberValue);

                                    Organization? currentOrganization = currentUserProvider.currentOrganization;
                                    if(currentOrganization != null){
                                      organizationService.patchOrganizationInfo(
                                          currentOrganization.organizationId!,
                                          {
                                            "numTel": phoneNumberValue,
                                            "matricule": matriculeController.value.text,
                                          }
                                      ).then((value) {
                                        globalErrorProvider.setNumTelError(null);
                                        changeLogScreen.incrementIndex();
                                        btnStateController.update(AsyncBtnState.success);

                                      }).catchError((onError){
                                        print(onError);
                                        btnStateController.update(AsyncBtnState.failure);
                                      });
                                    }
                                  }
                                  else{
                                    globalErrorProvider.setNumTelError("Numero de téléphone incorrcte");
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
