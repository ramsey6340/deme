import 'package:async_button/async_button.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:deme/constants.dart';
import 'package:deme/main-pages/given/given.dart';
import 'package:deme/models/financial_donation.dart';
import 'package:deme/models/method_payment.dart';
import 'package:deme/services/donation_service.dart';
import 'package:deme/services/payment_service.dart';
import 'package:deme/size_config.dart';
import 'package:deme/widgets/next_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../models/organization.dart';
import '../../../../provider/current_user_provider.dart';
import 'body_given.dart';


class FinancialPage extends StatefulWidget {
  const FinancialPage({super.key, required this.organization});
  final Organization organization;

  @override
  State<FinancialPage> createState() => _FinancialPageState();
}

class _FinancialPageState extends State<FinancialPage> {
  AsyncBtnStatesController btnStateController = AsyncBtnStatesController();
  DonationService donationService = DonationService();

  late Future<List<MethodPayment>> futureMethodPayment;
  PaymentService methodPaymentService = PaymentService();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureMethodPayment = methodPaymentService.getAllMethodPayment();
  }

  TextEditingController amountEditingController = TextEditingController();
  final List<String> genderItems = [
    'Male',
    'Female',
  ];

  String? methodPaymentId;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final currentUserProvider = Provider.of<CurrentUserProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: formKey,
        child: ListView(
          children: [
            SizedBox(
              height: getProportionateScreenHeight(40),
            ),
            Text(
              "Vous faite don de ",
              style:
                  GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 20),
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(10)),
                child: TextField(
                  controller: amountEditingController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  cursorColor: kPrimaryColor,
                  style: GoogleFonts.inter(
                      fontSize: 36, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    hintText: "Montant",
                    hintStyle: GoogleFonts.inter(
                        fontWeight: FontWeight.normal, fontSize: 24),
                    suffixIcon: Text(
                      "fcfa",
                      style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor),
                      textAlign: TextAlign.center,
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black,
                          width:
                              2.0), // Personnalisez la couleur et l'épaisseur ici
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black,
                          width:
                              2.0), // Personnalisez la couleur et l'épaisseur ici
                    ),
                  ),
                )),
            SizedBox(
              height: getProportionateScreenHeight(80),
            ),
            Text(
              "Mode de paiement",
              style:
                  GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 20),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            FutureBuilder(
              future: futureMethodPayment,
              builder: (context, snapshot) {
                return DropdownButtonFormField2<MethodPayment>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    // Add more decoration..
                  ),
                  hint: (snapshot.hasData)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(snapshot.data![0].imageUrl),
                              radius: 20,
                            ),
                            Text(
                              snapshot.data![0].name,
                              style: GoogleFonts.inter(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                          ],
                        )
                      : const Text("Choisissez un mode de paiement"),
                  items: (snapshot.hasData)
                      ? snapshot.data
                          ?.map((methodPayment) =>
                              DropdownMenuItem<MethodPayment>(
                                value: methodPayment,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(methodPayment.imageUrl),
                                      radius: 20,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      methodPayment.name,
                                      style: GoogleFonts.inter(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ))
                          .toList()
                      : [],
                  validator: (value) {
                    if (value == null) {
                      return 'Choisisser un mode de paiement';
                    }
                    setState(() {
                      methodPaymentId = value.methodPaymentId;
                    });
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      methodPaymentId = value?.methodPaymentId;
                    });
                  },
                  onSaved: (value) {
                    setState(() {
                      methodPaymentId = value?.methodPaymentId;
                    });
                  },
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.only(right: 16),
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      size: 30,
                      color: Colors.black,
                    ),
                    iconSize: 24,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                );
              },
            ),
            SizedBox(
              height: getProportionateScreenHeight(40),
            ),
            /*NextButton(text: 'Valider', press: () {

              AwesomeDialog(
                context: context,
                dialogType: DialogType.success,
                animType: AnimType.rightSlide,
                titleTextStyle: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 24),
                descTextStyle: GoogleFonts.inter(fontSize: 16),
                headerAnimationLoop: false,
                title: 'Donation reussi',
                desc:
                'Vôtre donation a bien été envoyé. Vous pouvez voir le reçu dans votre compte',
                btnOkOnPress: () {},
                btnOkIcon: Icons.check_circle,
                btnOkColor: Colors.green,
              ).show();
            }),*/


            // ========================Gestion du bouton asynchrone====================

            Center(
              child: AsyncTextBtn(
                style: kStyleNextBtn,
                asyncBtnStatesController: btnStateController,
                onPressed: () async {
                  btnStateController.update(AsyncBtnState.loading);
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    try {
                      double amount = double.parse(amountEditingController.value.text);
                      if(methodPaymentId != null && currentUserProvider.currentOrganization!=null){
                        MethodPayment methodPayment = await methodPaymentService.getMethodPaymentById(methodPaymentId!);
                        if(currentUserProvider.profile == KTypeUser.organization) {
                          Map<String, dynamic> financialDonation = {
                            "amount": amount,
                            "methodPaymentId": methodPayment.methodPaymentId
                          };
                          FinancialDonation newFinancialDonation = await donationService.
                          createFinancialDonationByOrganisationToOrganisation(
                              currentUserProvider.currentOrganization!.organizationId,
                              widget.organization.organizationId, financialDonation
                          );

                          if(context.mounted){
                            successDonation(context, widget.organization);
                          }
                        }
                      }

                    } catch(e){
                      btnStateController.update(AsyncBtnState.failure);
                      if(context.mounted){
                        errorDonation(context, widget.organization);
                      }
                      throw Exception(e);
                    }
                  }
                },

                loadingStyle: AsyncBtnStateStyle(
                  style: kStyleNextBtn,
                  widget: const SizedBox.square(
                    dimension: 30,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                ),

                successStyle: AsyncBtnStateStyle(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    foregroundColor: Colors.white,
                  ),
                  widget: const Row(
                    children: [
                      Icon(Icons.check, color: Colors.white,),
                      SizedBox(width: 4),
                      Text('Success!',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)
                      )
                    ],
                  ),
                ),
                failureStyle: AsyncBtnStateStyle(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  widget: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error, color: Colors.white,),
                      SizedBox(width: 4),
                      Text('Erreur !',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)
                      ),
                    ],
                  ),
                ),
                child: const Text(
                    'Continuer',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)
                ),
              ),
            ),

            // ========================Fin de la gestion du bouton asynchrone====================

          ],
        ),
      ),
    );
  }

  void successDonation(BuildContext context, Organization organization) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      titleTextStyle: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 24),
      descTextStyle: GoogleFonts.inter(fontSize: 16),
      headerAnimationLoop: false,
      title: 'Donation reussi',
      desc:
      'Vôtre donation a bien été envoyé. Vous pouvez voir le reçu dans votre compte',
      btnOkOnPress: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => BodyGiven(organization: organization)));
      },
      btnOkIcon: Icons.check_circle,
      btnOkColor: Colors.green,
    ).show();
  }
  void errorDonation(BuildContext context, Organization organization) {
    AnimatedButton(
      text: 'Echec de donation',
      color: Colors.red,
      pressEvent: () {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          headerAnimationLoop: false,
          title: 'Erreur',
          desc:
          "Une erreur s'est produit lors de la transaction",
          btnOkOnPress: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => BodyGiven(organization: organization)));
          },
          btnOkIcon: Icons.cancel,
          btnOkColor: Colors.red,
        ).show();
      },
    );
  }
}
