import 'package:flutter/material.dart';

import '../../../constantes.dart';
import '../../../size_config.dart';
import '../../../utils.dart';
import '../../../widgets/next_button.dart';
import '../../../widgets/phone_form_field_custom.dart';
import '../../../widgets/text_form_field_custom.dart';

class Body1 extends StatefulWidget {
  const Body1({super.key});

  @override
  State<Body1> createState() => _Body1State();
}

class _Body1State extends State<Body1> {
  final _formKey = GlobalKey<FormState>();

  String? passwordError;
  String? emailError;
  String? confirmPasswordError;

  String password = '';
  String confirmPassword = '';


  @override
  Widget build(BuildContext context) {
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 27*fem),
              child: Text(
                'Créer un compte',
                style:SafeGoogleFont (
                  'Inter',
                  fontSize: 36*ffem,
                  fontWeight: FontWeight.w700,
                  height: 1.2125*ffem/fem,
                  color: Colors.black,
                ),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        PhoneFormFieldCustom(
                          hintText: 'numéro de téléphone',
                          fillColor: Colors.white,
                          focusBorderSideColor: Colors.black,
                          borderSideColor: Colors.black,
                          hintTextColor: Colors.black.withOpacity(kTextFieldOpacity),
                          cursorColor: kRoundedCategoryColor,
                          inputTextColor: Colors.white,
                        ),
                        TextFormFieldCustom(
                          textInputType: TextInputType.emailAddress,
                          hintText: 'email',
                          hintTextColor: Colors.black.withOpacity(kTextFieldOpacity),
                          cursorColor: kRoundedCategoryColor,
                          errorText: emailError,
                          // la méthode validator
                          validator: (value){
                            if(!emailValidatorRegExp.hasMatch(value!)){
                              setState(() {
                                emailError = 'Email incorrecte';
                              });
                              return emailError;
                            }
                            return null;
                          },
                          // la méthode onChanged
                          onChanged: (value) {
                            if(value.isEmpty){
                              setState(() {
                                emailError = '';
                              });
                            }
                            else if(value.isNotEmpty && !emailValidatorRegExp.hasMatch(value)){
                              setState(() {
                                emailError = '';
                              });
                            }
                          },
                        ),
                        (emailError == null)?SizedBox(height: 24,):SizedBox(),
                        TextFormFieldCustom(
                          isPassword: true,
                          hintText: 'Mot de passe',
                          hintTextColor: Colors.black.withOpacity(kTextFieldOpacity),
                          cursorColor: kRoundedCategoryColor,
                          errorText: passwordError,
                          // la méthode validator
                          validator: (value){
                            if(value!.isEmpty){
                              setState(() {
                                password = value;
                                passwordError = "Entrer le mot de passe";
                              });
                              return passwordError;
                            }
                            else if(value.isNotEmpty && value.length<kPasswordMaxLength){
                              setState(() {
                                password = value;
                                passwordError = "Mot de passe faible";
                              });
                              return passwordError;
                            }
                            else{
                              password=value;
                              return null;
                            }
                          },
                          // la méthode onChanged
                          onChanged: (value) {
                            if(value.isEmpty){
                              setState(() {
                                passwordError = '';
                              });
                            }
                            else if(value.isNotEmpty && value.length<kPasswordMaxLength){
                              setState(() {
                                passwordError = '';
                              });
                            }
                            else if(value.isNotEmpty && value.length>=kPasswordMaxLength){
                              setState(() {
                                passwordError = '';
                              });
                            }
                          },
                        ),
                        (passwordError == null)?SizedBox(height: 24,):SizedBox(),
                        TextFormFieldCustom(
                          isPassword: true,
                          hintText: 'Confirmation de mot de passe',
                          hintTextColor: Colors.black.withOpacity(kTextFieldOpacity),
                          cursorColor: kRoundedCategoryColor,
                          errorText: confirmPasswordError,
                          // la méthode validator
                          validator: (value){
                            if(value!.isEmpty){
                              setState(() {
                                confirmPassword = value;
                                confirmPasswordError = "Entrer la confirmation du mot de passe";
                              });
                              return confirmPasswordError;
                            }
                            else if(value.isNotEmpty && value.length<kPasswordMaxLength){
                              setState(() {
                                confirmPassword = value;
                                confirmPasswordError = "mot de passe faible";
                              });
                              return confirmPasswordError;
                            }
                            else if (value != password){
                              setState(() {
                                confirmPassword = value;
                                confirmPasswordError = "les mots de passes ne correspondent pas";
                              });
                              return confirmPasswordError;
                            }
                            else{
                              confirmPassword=value;
                              return null;
                            }
                          },
                          // la méthode onChanged
                          onChanged: (value) {
                            if(value.isEmpty){
                              setState(() {
                                confirmPasswordError = '';
                              });
                            }
                            else if(value.isNotEmpty && value.length<kPasswordMaxLength){
                              setState(() {
                                confirmPasswordError = '';
                              });
                            }
                            else if(value.isNotEmpty && value.length>=kPasswordMaxLength){
                              setState(() {
                                confirmPasswordError = '';
                              });
                            }
                          },
                        ),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () => null/*Navigator.pushNamed(context, ForgotPasswordScreen.routeName)*/,
                              child: const Text(
                                'j\'ai oublié mon mot de passe',
                                style: TextStyle(color: Colors.white, decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        // Bouton de validation
                        NextButton(
                          borderRadius: 5,
                          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(100), vertical: getProportionateScreenHeight(10)),
                          color: kRoundedCategoryColor,
                          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          text: 'Continuer',
                          press: (){
                            if(_formKey.currentState!.validate()){
                              _formKey.currentState!.save();
                              // si tout est ok on peut maintenant afficher la page succès
                              //Navigator.pushNamed(context, SignUpAdditionalInfo.routeName);
                            }
                          },
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