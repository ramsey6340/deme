import 'package:deme/log-pages/log-up/log_up.dart';
import 'package:flutter/cupertino.dart';

import 'log-pages/log-in/log_in.dart';

final Map<String, WidgetBuilder> routes = {
  LogUp.routeName: (context) => LogUp(),
  LogIn.routeName: (context) => LogIn()
};