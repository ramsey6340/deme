import 'package:async_button/async_button.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:deme/models/assignment.dart';
import 'package:deme/services/donation_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../provider/current_user_provider.dart';

class AddDemandOrganization extends StatefulWidget {
  const AddDemandOrganization({super.key, required this.assignment});
  final Assignment assignment;

  @override
  State<AddDemandOrganization> createState() => _AddDemandOrganizationState();
}

class _AddDemandOrganizationState extends State<AddDemandOrganization> {
  AsyncBtnStatesController btnStateController = AsyncBtnStatesController();
  DonationService donationService = DonationService();

  final formKey = GlobalKey<FormState>();
  TextEditingController descriptionEditingController = TextEditingController();

  bool waiting = false;

  @override
  Widget build(BuildContext context) {
    final currentUserProvider = Provider.of<CurrentUserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 20,
        leading: const SizedBox(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                      }, child: const Icon(Icons.arrow_back, color: Colors.black,)),
                  Text(widget.assignment.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

                  SizedBox(
                    width: 100,
                    height: 35,
                    child: AsyncTextBtn(
                      style: TextButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))
                        )
                      ),
                      asyncBtnStatesController: btnStateController,
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          btnStateController.update(AsyncBtnState.loading);
                          try {
                            if(descriptionEditingController.value.text.isNotEmpty) {
                              Map<String, dynamic> demandMap = {
                                "description": descriptionEditingController.value.text,
                              };

                              String demandId = await donationService.createDemandByOrganization(
                                  currentUserProvider.currentOrganization!.organizationId!,
                                  widget.assignment.assignmentId!, demandMap);

                              setState(() {

                              });
                              if (context.mounted) {
                                successDemand(context);
                              }
                            }
                          } catch (e) {
                            btnStateController.update(AsyncBtnState.success);
                            if (context.mounted) {
                              errorDemand(context);
                            }
                            throw Exception(e);
                          }
                        }
                      },
                      loadingStyle: AsyncBtnStateStyle(
                        style: TextButton.styleFrom(
                            backgroundColor: kPrimaryColor
                        ),
                        widget: const SizedBox.square(
                          dimension: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      successStyle:
                      AsyncBtnStateStyle(
                        style: TextButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(50))
                            )
                        ),
                        widget: const Text('Success!',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                      ),

                      failureStyle: AsyncBtnStateStyle(
                        style: TextButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(50))
                            )
                        ),
                        widget: const Icon(
                          Icons.error,
                          color: Colors.white,
                        ),
                      ),
                      child: const Text('Poster',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                    ),
                  )

                  /*TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: kPrimaryColor
                    ),
                    onPressed: () {
                      setState(() {
                        waiting = true;
                      });

                      if(formKey.currentState!.validate()) {
                        formKey.currentState!.save();


                      }
                    },
                    child: (!waiting)?const Text("Poster", style: TextStyle(color: Colors.white),):
                    const SizedBox.square(
                      dimension: 20,
                        child: CircularProgressIndicator(color: Colors.white,)),
                  ),*/
                ],
              ),
              Expanded(
                child: TextFormField(
                  controller: descriptionEditingController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null, // Permet un nombre dynamique de lignes
                  expands: true,
                  decoration: InputDecoration(
                    hintText: 'Decrivez précisement votre problème et votre \nbesoin '
                        'pour la mission ${widget.assignment.title}',
                  ),
                  validator: (value) {
                    if(value!.isEmpty){
                      return "Entrer une description de la demande";
                    }
                    return null;
                  },
                ),
              ),

              // ========================Gestion du bouton asynchrone====================
              /*Center(
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


                            if(context.mounted){
                              setState(() {
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
                    style: TextButton.styleFrom(
                      minimumSize: Size(20, 20),
                        backgroundColor: kPrimaryColor,
                    ),
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
              ),*/
              // ========================Fin de la gestion du bouton asynchrone====================

              const SizedBox(height: 10,)
            ],
          ),
        ),
      ),
    );
  }

  void successDemand(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      titleTextStyle:
      GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 24),
      descTextStyle: GoogleFonts.inter(fontSize: 16),
      headerAnimationLoop: false,
      title: 'Succès',
      desc: 'Vôtre demande à bien été poster',
      btnOkOnPress: () {},
      btnOkIcon: Icons.check_circle,
      btnOkColor: Colors.green,
    ).show();
  }

  void errorDemand(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      titleTextStyle:
      GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 24),
      descTextStyle: GoogleFonts.inter(fontSize: 16),
      headerAnimationLoop: false,
      title: 'Echec',
      desc: "La demande n'a pas pu être poster",
      btnOkOnPress: () {},
      btnOkIcon: Icons.cancel,
      btnOkColor: Colors.red,
    ).show();
  }
}
