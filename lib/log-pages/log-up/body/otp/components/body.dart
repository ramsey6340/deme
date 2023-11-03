import 'package:deme/widgets/text_navigator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../constants.dart';
import '../../../../../size_config.dart';
import '../../../../../utils.dart';
import 'otp_form.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(18)),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Vérification OTP", style: GoogleFonts.inter(
                  fontSize: 30 * ffem,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),),
              Text("Nous avons envoyé un code au \n+223 72 19 ***", style: GoogleFonts.inter(fontSize: 18),textAlign: TextAlign.center),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Ce code expirera dans ...", style: GoogleFonts.inter(fontSize: 18),),
                  TweenAnimationBuilder(
                    tween: Tween(begin: 30.0, end: 0.0),
                    duration: const Duration(seconds: 30),
                    builder: (context, value, child) => Text("00:${value.toInt()}", style: GoogleFonts.inter(color: kPrimaryColor, fontWeight: FontWeight.bold),),
                    onEnd: (){},
                  ),
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(30)),
              OTPForm(),
              SizedBox(height: getProportionateScreenHeight(30),),
              Container(
                margin: EdgeInsets.fromLTRB(
                    7 * fem, 0 * fem, 0 * fem, 0 * fem),
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Text('Renvoyer le code OTP',
                    style: SafeGoogleFont(
                      'Inter',
                      fontSize: 16 * ffem,
                      fontWeight: FontWeight.w500,
                      height: 1.2125 * ffem / fem,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
