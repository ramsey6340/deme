import 'package:deme/log-pages/log-up/log_up.dart';
import 'package:deme/main-pages/profile-page/body/setting-pages/assignment/setting_assignment.dart';
import 'package:flutter/cupertino.dart';

import 'log-pages/forgot-password/forgot_otp_field.dart';
import 'log-pages/forgot-password/forgot_email_field.dart';
import 'log-pages/forgot-password/reset_password.dart';
import 'log-pages/log-in/log_in.dart';
import 'log-pages/log-up/choose_account_type.dart';
import 'main-pages/given/given.dart';
import 'main_screen.dart';

final Map<String, WidgetBuilder> routes = {
  LogUp.routeName: (context) => LogUp(),
  LogIn.routeName: (context) => LogIn(),
  ChooseAccountType.routeName: (context) => ChooseAccountType(),
  MainScreen.routeName: (context) => MainScreen(),
  ForgotEmailField.routeName: (context) => ForgotEmailField(),
  ForgotOtpField.routeName: (context) => ForgotOtpField(),
  ResetPassword.routeName: (context) => ResetPassword(),
  Given.routeName: (context) => Given(),
  SettingAssignment.routeName: (context) => SettingAssignment(),
};