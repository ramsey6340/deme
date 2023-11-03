import 'package:deme/widgets/text_navigator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../provider/change_log_screen.dart';
import '../../../provider/type_user_log_up.dart';
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
                          showIconModif: true,
                        ),
                        const SizedBox(
                          height: 20,
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
                              textInputType: TextInputType.emailAddress,
                              hintText: 'Matricule',
                              hintTextColor: Colors.black.withOpacity(kTextFieldOpacity),
                              cursorColor: kRoundedCategoryColor,
                            ),
                          ],
                        ):SizedBox(),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        // Bouton de validation
                        NextButton(
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(100),
                              vertical: getProportionateScreenHeight(10)),
                          press: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              changeLogScreen.incrementIndex();
                            }
                          },
                        ),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        (typeUserLogUp.typeUserLogUp == 'user')?
                        TextNavigator(text: 'Ignorer', isReturn: false, onTap: (){
                          changeLogScreen.incrementIndex();
                        }):SizedBox(),
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