import 'package:deme/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/cause.dart';

class CauseCard extends StatelessWidget {
  const CauseCard({super.key, required this.cause, this.onTap,});
  final Cause cause;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
        padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
        width: 180,
        decoration: BoxDecoration (
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage (
            fit: BoxFit.cover,
            image: NetworkImage (
              cause.imageUrl,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
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
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      height: 1.2125,
                    overflow: TextOverflow.ellipsis
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