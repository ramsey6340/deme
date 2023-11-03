import 'package:deme/constants.dart';
import 'package:deme/log-pages/log-up/body/body1.dart';
import 'package:deme/log-pages/log-up/body/body2.dart';
import 'package:deme/provider/change_log_screen.dart';
import 'package:deme/widgets/next_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils.dart';
import 'body/body3.dart';
import 'body/finish_log_message.dart';
import 'body/choose_method_payment.dart';
import 'body/init_preferred_cause.dart';
import 'body/otp/otp_screen.dart';
import 'choose_account_type.dart';

class LogUp extends StatelessWidget {
  static const String routeName = "log_up";
  const LogUp({super.key});

  @override
  Widget build(BuildContext context) {
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    List<Widget> logBodies = [ChooseAccountType(), Body1(), OTPScreen(), Body2(), FinishLogMessage(), ChooseMethodPayment(), InitPreferredCause()];

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
                Consumer<ChangeLogScreen>(builder: (context, changeLogScreen, child) => logBodies[changeLogScreen.logIndex]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
