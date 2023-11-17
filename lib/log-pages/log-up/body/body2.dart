import 'package:deme/services/user_service.dart';
import 'package:deme/widgets/text_navigator.dart';
import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../models/user.dart';
import '../../../provider/change_log_screen_provider.dart';
import '../../../provider/current_user_provider.dart';
import '../../../provider/type_user_log_up_provider.dart';
import '../../../size_config.dart';
import '../../../utils.dart';
import '../../../widgets/next_button.dart';
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
                        (typeUserLogUp.typeUserLogUp == 'organization')? SizedBox(height: getProportionateScreenHeight(20)): SizedBox(),
                        (typeUserLogUp.typeUserLogUp == 'organization')?
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
                        // Bouton de validation
                        /*NextButton(
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(100),
                              vertical: getProportionateScreenHeight(10)),
                          press: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              changeLogScreen.incrementIndex();
                            }
                          },
                        ),*/

                        Center(
                          child: EasyButton(
                            idleStateWidget: Text(
                              'Continuer',
                              style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                            ),
                            loadingStateWidget: const CircularProgressIndicator(
                              strokeWidth: 3.0,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                            useWidthAnimation: true,
                            useEqualLoadingStateWidgetDimension: true,
                            width: double.infinity,
                            height: getProportionateScreenHeight(50),
                            contentGap: 6.0,
                            borderRadius: 5,
                            buttonColor: kPrimaryColor,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();

                                if(typeUserLogUp.typeUserLogUp == 'user' && numTelController.value.text.isNotEmpty){
                                  currentUserProvider.setNumTel(phoneNumberValue);
                                  final currentUser = currentUserProvider.currentUser;
                                  if(currentUser != null){
                                    userService.patchUserInfo(
                                        currentUser.userId!,
                                        {"numTel": currentUser.numTel}
                                    ).then((value) {
                                      print(value);
                                      changeLogScreen.incrementIndex();

                                    }).catchError((onError){
                                      print(onError);
                                    });
                                  }
                                }
                              }
                            }
                          ),
                        ),
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
