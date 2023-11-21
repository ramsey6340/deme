import 'package:deme/size_config.dart';
import 'package:flutter/material.dart';

const kTextColor = Color(0xFF757575);
const Color kRoundedCategoryColor = Color(0xFF0077B5);
const Color kPrimaryColor = Color(0xFF0077B5);
const kTextFieldOpacity = 0.7;
const kAnimationDuration = Duration(milliseconds: 200);
double baseWidth = 428;

const kNumberOfLogUpPage = 9;
const kNumberOfHomeOption = 2;
const kNumberOfGivenOption = 2;

// Decoration correspondant à chaque cellule du formulaire OTP
final otpFieldDecoration = InputDecoration(
  border: const OutlineInputBorder(borderSide: BorderSide(width: 2)),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: kPrimaryColor, width: 2),
    borderRadius: BorderRadius.circular(10),
  ),
  contentPadding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(25)),
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: kTextColor, width: 2)
  ),
);

const int kPasswordMaxLength = 6;
const int kFirstNameMinLength = 2;
const int kLastNameMinLength = 2;
const int maxLengthOfExampleProduct = 12;
final RegExp emailValidatorRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final RegExp birthDayRegExp = RegExp(r"^[0-9]{2}\/[0-9]{2}\/[0-9]{4}");


String currentUserId = '1';
const baseUrl = "http://10.175.48.172:8080";


ButtonStyle? kStyleNextBtn = ButtonStyle(
  padding: MaterialStateProperty.all(
    EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(100),
        vertical: getProportionateScreenHeight(10)),
  ),
  elevation: MaterialStateProperty.all(0),
  overlayColor: MaterialStateProperty.all(Colors.transparent),
  backgroundColor: MaterialStateProperty.all(kPrimaryColor),
  shape: MaterialStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
  ),
  side: MaterialStateProperty.all(
    const BorderSide(color: Colors.transparent, width: 1),
  ),
);

class KTypeUser {
  static String user = 'user';
  static String organization = 'organization';
}

String kLoginMessageError = "email ou mot de passe incorrecte";