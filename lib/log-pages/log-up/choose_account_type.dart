import 'package:deme/provider/type_user_log_up_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../widgets/next_button.dart';
import '../../provider/change_log_screen_provider.dart';
import '../../services/shared_preferences_service.dart';
import '../../widgets/list_tile_radio_custom.dart';
import 'log_up.dart';

class ChooseAccountType extends StatefulWidget {
  static const String routeName = "choose_account_type";
  const ChooseAccountType({super.key});

  @override
  State<ChooseAccountType> createState() => _ChooseAccountTypeState();
}

class _ChooseAccountTypeState extends State<ChooseAccountType> {
  final _formKey = GlobalKey<FormState>();

  SharedPreferencesService sharedPreferencesService = SharedPreferencesService();
  String? currentValue;

  @override
  Widget build(BuildContext context) {
    final changeLogScreen = Provider.of<ChangeLogScreenProvider>(context);
    final typeUserLogUp = Provider.of<TypeUserLogUpProvider>(context);
    print(typeUserLogUp.typeUserLogUp);

    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 27 * fem),
              child: Text(
                'Êtes-vous une organisation humanitaire ?',
                style: GoogleFonts.inter(
                    fontSize: 30 * ffem,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ListTileRadioCustom(
                          title: 'OUI',
                          radioValue: KTypeUser.organization,
                          radioGroupValue: currentValue,
                          radioOnChanged: (value) {
                            setState(() {
                              currentValue = KTypeUser.organization;
                            });
                            typeUserLogUp.setTypeUserLogUp(currentValue!);
                          },
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                        ListTileRadioCustom(
                          title: 'NON',
                          radioValue: KTypeUser.user,
                          radioGroupValue: currentValue,
                          radioOnChanged: (value) {
                            setState(() {
                              currentValue = KTypeUser.user;
                            });
                            typeUserLogUp.setTypeUserLogUp(currentValue!);
                          },
                        ),
                        SizedBox(height: getProportionateScreenHeight(50)),
                        NextButton(
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(100),
                              vertical: getProportionateScreenHeight(10)),
                          press: () {
                            sharedPreferencesService.setTypeUser(typeUserLogUp.typeUserLogUp!);
                            (typeUserLogUp.typeUserLogUp != null)?changeLogScreen.incrementIndex():null;
                          },
                        ),
                        SizedBox(height: getProportionateScreenHeight(20)),

                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
