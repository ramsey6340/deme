import 'package:deme/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckboxListTileCustom extends StatelessWidget {
  const CheckboxListTileCustom({super.key, this.checkBoxValue=false, required this.onChangedCheckValue, required this.title, required this.imageUrl});
  final String title;
  final String imageUrl;
  final bool checkBoxValue;
  final Function(bool?) onChangedCheckValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(5.0),
        color: (checkBoxValue)?const Color(0xFF0077B5).withOpacity(0.1):null
      ),
      child: CheckboxListTile(
        value: checkBoxValue,
        secondary: CircleAvatar(backgroundImage: NetworkImage(imageUrl), radius: 15,),
        title: Text(title, style: GoogleFonts.inter(
            color: const Color(0xFF676666), fontSize: 18, fontWeight: FontWeight.w500
        ),),
        onChanged: onChangedCheckValue,
        checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        controlAffinity: ListTileControlAffinity.trailing,
        visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
        activeColor: kPrimaryColor,
      ),
    );
  }
}
