import 'package:deme/widgets/checkbox_list_title_custom.dart';
import 'package:deme/widgets/text_navigator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../models/method_payment.dart';
import '../../../provider/change_log_screen.dart';
import '../../../size_config.dart';
import '../../../utils.dart';
import '../../../widgets/next_button.dart';

class ChooseMethodPayment extends StatefulWidget {
  const ChooseMethodPayment({super.key});

  @override
  State<ChooseMethodPayment> createState() => _ChooseMethodPaymentState();
}

class _ChooseMethodPaymentState extends State<ChooseMethodPayment> {
  List<MethodPayment> methodPaymentsData = [
    MethodPayment(
        methodPaymentId: '1',
        name: "Orange Money",
        description: null,
        imageUrl: "assets/data_test/om.png",
        termsOfUse: null),
    MethodPayment(
        methodPaymentId: '2',
        name: "Moov Money",
        description: null,
        imageUrl: "assets/data_test/mm.png",
        termsOfUse: null),
    MethodPayment(
        methodPaymentId: '3',
        name: "Pay Pal",
        description: null,
        imageUrl: "assets/data_test/pp.png",
        termsOfUse: null),
    MethodPayment(
        methodPaymentId: '4',
        name: "Sama Money",
        description: null,
        imageUrl: "assets/data_test/sm.png",
        termsOfUse: null),
    MethodPayment(
        methodPaymentId: '5',
        name: "Orange Money",
        description: null,
        imageUrl: "assets/data_test/om.png",
        termsOfUse: null),
    MethodPayment(
        methodPaymentId: '6',
        name: "Moov Money",
        description: null,
        imageUrl: "assets/data_test/mm.png",
        termsOfUse: null),
    MethodPayment(
        methodPaymentId: '7',
        name: "Pay Pal",
        description: null,
        imageUrl: "assets/data_test/pp.png",
        termsOfUse: null),
    MethodPayment(
        methodPaymentId: '8',
        name: "Sama Money",
        description: null,
        imageUrl: "assets/data_test/sm.png",
        termsOfUse: null),
  ];

  List<bool> methodPayments = List.generate(13, (index) => false);

  @override
  Widget build(BuildContext context) {
    final changeLogScreen = Provider.of<ChangeLogScreen>(context);

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
                'Quel sont vos modes de paiement préferé ?',
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
                    child: ListView.builder(
                      itemCount: methodPaymentsData.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: CheckboxListTileCustom(
                              checkBoxValue: methodPayments[index],
                              onChangedCheckValue: (value) {
                                setState(() {
                                  methodPayments[index] = value!;
                                });
                              },
                              title: methodPaymentsData[index].name,
                              imageUrl: methodPaymentsData[index].imageUrl),
                        );
                      },
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
                        changeLogScreen.incrementIndex();
                      }
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  TextNavigator(text: 'Ignorer', isReturn: false, onTap: (){
                    changeLogScreen.incrementIndex();
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
