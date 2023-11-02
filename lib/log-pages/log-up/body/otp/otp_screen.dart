import 'package:flutter/material.dart';
import '../../../../constants.dart';
import 'components/body.dart';

class OTPScreen extends StatelessWidget {
  static String routeName = 'otp_screen';
  const OTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fem = MediaQuery.of(context).size.width / baseWidth;
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
                  height: 150*fem,
                  child: Image.asset(
                    'assets/images/header-img.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Body(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
