import 'package:flutter/material.dart';

const kTextColor = Color(0xFF757575);
const Color kRoundedCategoryColor = Color(0xFF0077B5);
const Color kPrimaryColor = Color(0xFF0077B5);
const kTextFieldOpacity = 0.7;
const kAnimationDuration = Duration(milliseconds: 200);
double baseWidth = 428;

const int kPasswordMaxLength = 4;
const int kFirstNameMinLength = 2;
const int kLastNameMinLength = 2;
const int maxLengthOfExampleProduct = 12;
final RegExp emailValidatorRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");