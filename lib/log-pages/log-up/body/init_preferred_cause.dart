import 'package:deme/models/cause.dart';
import 'package:deme/provider/change_log_screen.dart';
import 'package:deme/provider/type_user_log_up.dart';
import 'package:deme/widgets/checkbox_list_title_custom.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../main_screen.dart';
import '../../../models/method_payment.dart';
import '../../../size_config.dart';
import '../../../utils.dart';
import '../../../widgets/cause_card.dart';
import '../../../widgets/next_button.dart';
import '../../../widgets/text_navigator.dart';

class InitPreferredCause extends StatefulWidget {
  const InitPreferredCause({super.key});

  @override
  State<InitPreferredCause> createState() => _Body4State();
}

class _Body4State extends State<InitPreferredCause> {
  List<Cause> causesData = [
    Cause(
        causeId: '1',
        name: "Education",
        description: null,
        imageUrl: "assets/data_test/education.png"),
    Cause(
        causeId: '2',
        name: "Sante",
        description: null,
        imageUrl: "assets/data_test/sante.png"),
    Cause(
        causeId: '3',
        name: "Environnement",
        description: null,
        imageUrl: "assets/data_test/environnement.png"),
    Cause(
        causeId: '4',
        name: "Refugieux",
        description: null,
        imageUrl: "assets/data_test/refugieux.png"),
  ];

  List<bool> causesCheckboxValues = List.generate(4, (index) => false);

  @override
  Widget build(BuildContext context) {
    final changeLogScreen = Provider.of<ChangeLogScreen>(context);
    final typeUserLogUp = Provider.of<TypeUserLogUp>(context);

    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text((typeUserLogUp.typeUserLogUp == 'user')?
                'Quelle sont vos causes préferé ?':'Quelles sont les causes que vôtre organisation defend ?',
                style: GoogleFonts.inter(
                    fontSize: 30 * ffem,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: getProportionateScreenHeight(500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  Expanded(
                    child: GridView.builder(
                      itemCount: causesData.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: CauseCard(
                            checkBoxValue: causesCheckboxValues[index],
                            cause: causesData[index],
                            onChangedCheckBoxValue: (value) {
                              setState(() {
                                causesCheckboxValues[index] = value!;
                              });
                            },
                          ),
                        );
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        childAspectRatio: 0.96,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  NextButton(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(100),
                          vertical: getProportionateScreenHeight(10)),
                      press: () {
                        Navigator.pushNamed(context, MainScreen.routeName);
                      }
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  TextNavigator(
                    onTap: () {
                      changeLogScreen.decrementIndex();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
