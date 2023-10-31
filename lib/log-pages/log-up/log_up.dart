import 'package:deme/constantes.dart';
import 'package:deme/log-pages/log-up/body/body1.dart';
import 'package:flutter/material.dart';

import '../../utils.dart';

class LogUp extends StatelessWidget {
  const LogUp({super.key});

  @override
  Widget build(BuildContext context) {
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration (
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
                  width: 428*fem,
                  height: 243*fem,
                  child: Image.asset(
                    'assets/images/header-img.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Body1(),
                /*Container(
                  // vousavezdjuncompteseconnectS4J (6:28)
                  margin: EdgeInsets.fromLTRB(7*fem, 0*fem, 0*fem, 0*fem),
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom (
                      padding: EdgeInsets.zero,
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: SafeGoogleFont (
                          'Inter',
                          fontSize: 16*ffem,
                          fontWeight: FontWeight.w500,
                          height: 1.2125*ffem/fem,
                          color: Color(0xff000000),
                        ),
                        children: [
                          const TextSpan(
                            text: 'Vous avez déjà un compte ? ',
                          ),
                          TextSpan(
                            text: 'Se connecté',
                            style: SafeGoogleFont (
                              'Inter',
                              fontSize: 16*ffem,
                              fontWeight: FontWeight.w500,
                              height: 1.2125*ffem/fem,
                              color: kPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
