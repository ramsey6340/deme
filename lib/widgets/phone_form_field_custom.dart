import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../constants.dart';


class PhoneFormFieldCustom extends StatelessWidget {
  const PhoneFormFieldCustom({
    Key? key,
    this.controller,
    this.initialCountryCode='ML',
    this.initialValue,
    this.hintText,
    this.searchText='Rechercher un pays',
    this.invalidNumberMessage='',
    this.borderSideColor=Colors.black,
    this.focusBorderSideColor=kRoundedCategoryColor,
    this.fillColor=Colors.black,
    this.hintTextColor=kTextColor,
    this.cursorColor=Colors.blue,
    this.inputTextColor=Colors.black,
    this.onCountryChanged,
    this.onChanged,
    this.onSaved,
    this.errorBorderColor=Colors.black,
    this.focusErrorBorderColor=Colors.black,
    this.validator,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? initialCountryCode;
  final String? initialValue;
  final String? hintText;
  final String searchText;
  final String? invalidNumberMessage;
  final Color borderSideColor;
  final Color errorBorderColor;
  final Color focusErrorBorderColor;
  final Color focusBorderSideColor;
  final Color fillColor;
  final Color hintTextColor;
  final Color cursorColor;
  final Color inputTextColor;
  final void Function(Country)? onCountryChanged;
  final void Function(PhoneNumber)? onChanged;
  final Function(PhoneNumber?)? onSaved;
  final FutureOr<String?> Function(PhoneNumber?)? validator;

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      controller: controller,
      dropdownIcon: const Icon(Icons.arrow_drop_down, color: Colors.black54,),
      disableLengthCheck: false,
      searchText: searchText,
      invalidNumberMessage: invalidNumberMessage,
      dropdownTextStyle: TextStyle(color: hintTextColor, fontWeight: FontWeight.bold),
      style: TextStyle(color: inputTextColor),
      cursorColor: cursorColor,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        filled: true,
        fillColor: fillColor,
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 14, color: hintTextColor),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: borderSideColor)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: focusBorderSideColor,)
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: errorBorderColor,)
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: focusErrorBorderColor)
        ),
      ),
      initialCountryCode: 'ML',
      initialValue: initialValue,
      onCountryChanged: onCountryChanged,
      onSaved: onSaved,
      onChanged: onChanged,
      validator: validator,
    );
  }
}
