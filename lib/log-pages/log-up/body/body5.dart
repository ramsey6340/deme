import 'package:deme/models/cause.dart';
import 'package:deme/widgets/checkbox_list_title_custom.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants.dart';
import '../../../models/method_payment.dart';
import '../../../size_config.dart';
import '../../../utils.dart';
import '../../../widgets/cause_card.dart';
import '../../../widgets/next_button.dart';
import '../../../widgets/text_navigator.dart';

class Body5 extends StatefulWidget {
  const Body5({super.key});

  @override
  State<Body5> createState() => _Body4State();
}

class _Body4State extends State<Body5> {
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
              child: Text(
                'Quel sont vos causes préferé ?',
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
                      press: () {}),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  TextNavigator(
                    onTap: () {
                      Navigator.pop(context);
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

/*class CauseCard extends StatelessWidget {
  const CauseCard({
    super.key,
    required this.fem,
    required this.causesData,
    required this.ffem,
  });

  final double fem;
  final List<Cause> causesData;
  final double ffem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 15*fem, 0*fem),
      padding: EdgeInsets.fromLTRB(0*fem, 12*fem, 0*fem, 0*fem),
      width: 180*fem,
      decoration: BoxDecoration (
        borderRadius: BorderRadius.circular(20*fem),
        image: DecorationImage (
          fit: BoxFit.cover,
          image: AssetImage (
            causesData[index].imageUrl,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 15*fem, 104*fem),
            width: 24*fem,
            height: 24*fem,
            child: Checkbox(
              value: false,
              onChanged: (value) {},
              side: BorderSide(color: Colors.white, width: 2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
          ),
          Container(
            // group6Gpr (I10:266;10:262)
            width: double.infinity,
            height: 40*fem,
            decoration: BoxDecoration (
              color: Color(0xc6000000),
              borderRadius: BorderRadius.only (
                bottomRight: Radius.circular(20*fem),
                bottomLeft: Radius.circular(20*fem),
              ),
            ),
            child: Center(
              child: Text(
                causesData[index].name,
                textAlign: TextAlign.center,
                style: SafeGoogleFont (
                  'Inter',
                  fontSize: 20*ffem,
                  fontWeight: FontWeight.w500,
                  height: 1.2125*ffem/fem,
                  color: Color(0xffffffff),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}*/
