import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextNavigator extends StatelessWidget {
  const TextNavigator({
    super.key, this.text="Retour", this.isReturn=true, required this.onTap,
  });

  final String text;
  final bool isReturn;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
        child: (isReturn)?
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.arrow_back),
            const SizedBox(width: 10,),
            Text(
              text,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400
              ),
            ),
          ],
        ):
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400
              ),
            ),
            const SizedBox(width: 10,),
            const Icon(Icons.arrow_forward)
          ],
        ),
      ),
    );
  }
}