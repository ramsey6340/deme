import 'dart:ffi';

import 'package:async_button/async_button.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:deme/data-test/data_test.dart';
import 'package:deme/models/material_donation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../constants.dart';
import '../../../../models/organization.dart';
import '../../../../provider/current_user_provider.dart';
import '../../../../services/donation_service.dart';
import '../../../../widgets/address_card.dart';
import '../../../../widgets/next_button.dart';
import 'body_given.dart';

class MaterialPageGiven extends StatefulWidget {
  const MaterialPageGiven({super.key, required this.organization});
  final Organization organization;


  @override
  State<MaterialPageGiven> createState() => _MaterialPageGivenState();
}

class _MaterialPageGivenState extends State<MaterialPageGiven> {
  bool isSuccess = false;
  AsyncBtnStatesController btnStateController = AsyncBtnStatesController();

  DonationService donationService = DonationService();
  final formKey = GlobalKey<FormState>();
  TextEditingController descriptionEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: (isSuccess)?successDonationPage(widget.organization):descriptionDonationPage(),
      ),
    );
  }


  Widget descriptionDonationPage() {
    final currentUserProvider = Provider.of<CurrentUserProvider>(context);

    return Form(
      key: formKey,
      child: Column(
        children: [
          Expanded(
            child: TextFormField(
              controller: descriptionEditingController,
              keyboardType: TextInputType.multiline,
              maxLines: null, // Permet un nombre dynamique de lignes
              expands: true,
              decoration: const InputDecoration(
                hintText: 'Décrivez précisément les dons matériels que \nvous souhaitez faire',
              ),
              validator: (value) {
                if(value!.isEmpty){
                  return "Entrer une description de la donation";
                }
                return null;
              },
            ),
          ),

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
                    if(descriptionEditingController.value.text.isNotEmpty){
                      if(currentUserProvider.profile == KTypeUser.organization) {
                        MaterialDonation materialDonation = MaterialDonation(
                            donationId: null,
                            used: null,
                            creationDate: null,
                            descriptionMaterialDonation: descriptionEditingController.value.text,
                            donorUser: null,
                            donorOrganization: null,
                            imageUrl: null,
                            deleted: false,
                            beneficiaryOrganization: null,
                            beneficiaryDemand: null
                        );

                        MaterialDonation newMaterialDonation = await donationService.
                        createMaterialDonationByOrganisationToOrganisation(
                            currentUserProvider.currentOrganization!.organizationId,
                            widget.organization.organizationId, materialDonation.toJson()
                        );

                        setState(() {

                        });

                        if(context.mounted){
                          setState(() {
                            isSuccess=true;
                            btnStateController = AsyncBtnStatesController();
                            descriptionEditingController.clear();
                          });
                        }
                      }
                    }

                  } catch(e){
                    btnStateController.update(AsyncBtnState.failure);
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

          const SizedBox(height: 10,)
        ],
      ),
    );
  }

  Widget successDonationPage(Organization organization) {
    return ListView(
      children: [
        const SizedBox(height: 30,),
        Text("Il reste encore un pas",
          style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        const Icon(Icons.check_circle, color: Colors.green, size: 150,),
        Text("Pour completer vôtre donation vous devez livrer le materiel "
            "à l’adresse situer ci-dessous.",
          style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10,),
        AddressCard(
          titleAddress: organization.login!,
          numTel: organization.numTel,
          address: addresses[0],
          onTapAddress: (){},
        ),
        const SizedBox(height: 40,),
        NextButton(text: 'Terminer', press: () {
          setState(() {
            isSuccess=false;
          });
          //Navigator.push(context, MaterialPageRoute(builder: (context) => BodyGiven(organization: organization)));
        },
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width*0.3, vertical: 10)
        ),

      ],
    );
  }
}
