import 'package:flutter/material.dart';
import '../../../../constants.dart';
import 'components/body.dart';

class OTPScreen extends StatelessWidget {
  static String routeName = 'otp_screen';
  const OTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration (
            color: Colors.white,
          ),
          child: const SingleChildScrollView(
            child: Body(),
          ),
        ),
      ),
    );
  }
}
