import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
typedef ValueChanged<T> = void Function(T value);


class ListTileRadioCustom<T> extends StatelessWidget {
  const ListTileRadioCustom({
    super.key,
    required this.title,
    required this.radioValue,
    this.radioGroupValue,
    this.radioOnChanged
  });

  final String title;
  final T radioValue;
  final T? radioGroupValue;
  final ValueChanged<T?>? radioOnChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration (
        border: Border.all(color: (radioValue == radioGroupValue)?kPrimaryColor:Colors.black),
        color: (radioValue == radioGroupValue)?const Color(0xFF0077B5).withOpacity(0.1):Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: ListTile(
        onTap: (){
          radioOnChanged?.call(radioGroupValue);
        },
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: kPrimaryColor
          ),
        ),
        trailing: Radio(
            value: radioValue,
            groupValue: radioGroupValue,
            onChanged: radioOnChanged
        ),
      ),
    );
  }
}