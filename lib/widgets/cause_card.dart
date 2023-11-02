import 'package:deme/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/cause.dart';

class CauseCard extends StatelessWidget {
  const CauseCard({super.key, required this.cause, this.checkBoxValue=false, required this.onChangedCheckBoxValue});
  final Cause cause;
  final bool checkBoxValue;
  final Function(bool?)? onChangedCheckBoxValue;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChangedCheckBoxValue?.call(!checkBoxValue);
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
        padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
        width: 180,
        decoration: BoxDecoration (
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage (
            fit: BoxFit.cover,
            image: AssetImage (
              cause.imageUrl,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 15, 104),
              width: 24,
              height: 24,
              child: Checkbox(
                value: checkBoxValue,
                onChanged: onChangedCheckBoxValue,
                side: const BorderSide(color: Colors.white, width: 2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                activeColor: kPrimaryColor
              ),
            ),
            Container(
              // group6Gpr (I10:266;10:262)
              width: double.infinity,
              height: 40,
              decoration: const BoxDecoration (
                color: Color(0xc6000000),
                borderRadius: BorderRadius.only (
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: Center(
                child: Text(
                  cause.name,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    height: 1.2125
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}