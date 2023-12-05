import 'package:async_button/async_button.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:deme/provider/current_user_provider.dart';
import 'package:deme/services/activity_service.dart';
import 'package:deme/services/cause_service.dart';
import 'package:deme/size_config.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../constants.dart';
import '../../../../../models/cause.dart';
import '../../../../../services/shared_preferences_service.dart';
import '../../../../../widgets/text_form_field_custom.dart';

class SettingAssignment extends StatefulWidget {
  const SettingAssignment({super.key});

  @override
  State<SettingAssignment> createState() => _SettingAssignmentState();
}

class _SettingAssignmentState extends State<SettingAssignment> {
  SharedPreferencesService sharedPreferencesService = SharedPreferencesService();
  AsyncBtnStatesController btnStateController = AsyncBtnStatesController();
  CauseService causeService = CauseService();
  ActivityService activityService = ActivityService();
  late Future<List<Cause>> futureCause;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureCause = causeService.getAllCause();
  }

  final _formKeyAssignment = GlobalKey<FormState>(debugLabel: 'create_assignment');
  TextEditingController titleController = TextEditingController();
  TextEditingController resourceController = TextEditingController();
  TextEditingController needController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String? selectCauseId;
  // Les erreurs
  String? titleError;

  @override
  Widget build(BuildContext context) {
    final currentUserProvider = Provider.of<CurrentUserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Créer une mission",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10), vertical: 20),
        child: Form(
          key: _formKeyAssignment,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Titre",
                      style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                    ),
                    TextFormFieldCustom(
                      controller: titleController,
                      textInputType: TextInputType.text,
                      hintText: 'Ex: Education',
                      hintTextColor: Colors.black.withOpacity(kTextFieldOpacity),
                      cursorColor: kRoundedCategoryColor,
                      errorText: titleError,
                      validator: (value) {
                        if (value!.isEmpty) {
                          setState(() {
                            titleError =
                                'renseigner votre le titre de la mission';
                          });
                          return titleError;
                        }
                        return null;
                      },
                      // la méthode onChanged
                      onChanged: (value) {
                        if (value.isEmpty) {
                          setState(() {
                            titleError = '';
                          });
                        } else if (value.isNotEmpty &&
                            !emailValidatorRegExp.hasMatch(value)) {
                          setState(() {
                            titleError = '';
                          });
                        }
                      },
                    ),
                  ],
                ),

                const SizedBox(
                  height: 5,
                ),
                // Les cause
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Cause",
                      style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                    ),
                    FutureBuilder(
                      future: futureCause,
                      builder: (context, snapshot) {
                        return DropdownButtonFormField2<Cause>(
                          isExpanded: true,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 16),
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
                                      backgroundImage: NetworkImage(
                                          snapshot.data![0].imageUrl),
                                      radius: 20,
                                    ),
                                    Text(
                                      snapshot.data![0].name,
                                      style: GoogleFonts.inter(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                )
                              : const Text("Choisissez une cause"),
                          items: (snapshot.hasData)
                              ? snapshot.data
                                  ?.map((methodPayment) =>
                                      DropdownMenuItem<Cause>(
                                        value: methodPayment,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  methodPayment.imageUrl),
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
                              selectCauseId = value.causeId;
                            });
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              selectCauseId = value?.causeId;
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              selectCauseId = value?.causeId;
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
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),

                // Description de la mission
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Description de la mission",
                      style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                    ),
                    TextFormFieldCustom(
                      controller: descriptionController,
                      textInputType: TextInputType.multiline,
                      maxLine: 5,
                      hintText: 'Decrivez votre mission',
                      hintTextColor: Colors.black.withOpacity(kTextFieldOpacity),
                      cursorColor: kRoundedCategoryColor,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),

                // Description des besoins
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Quels sont vos besoins ?",
                      style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                    ),
                    TextFormFieldCustom(
                      controller: needController,
                      textInputType: TextInputType.multiline,
                      maxLine: 5,
                      hintText: 'Decrivez les besoins dont vous avez besoins',
                      hintTextColor: Colors.black.withOpacity(kTextFieldOpacity),
                      cursorColor: kRoundedCategoryColor,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),

                // Description des ressources existant
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Quelles sont les ressources dont vous disposez ?",
                      style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                    ),
                    TextFormFieldCustom(
                      controller: resourceController,
                      textInputType: TextInputType.multiline,
                      maxLine: 5,
                      hintText:
                          'Decrivez les ressources dont vous disposez actuellement',
                      hintTextColor: Colors.black.withOpacity(kTextFieldOpacity),
                      cursorColor: kRoundedCategoryColor,
                    ),
                  ],
                ),

                // Validation des données

                // ========================Gestion du bouton asynchrone====================

                Center(
                  child: AsyncTextBtn(
                    style: kStyleNextBtn,
                    asyncBtnStatesController: btnStateController,
                    onPressed: () async {
                      if (_formKeyAssignment.currentState!.validate()) {
                        _formKeyAssignment.currentState!.save();
                        btnStateController.update(AsyncBtnState.loading);
                        try {
                          String? typeUser = await sharedPreferencesService.getTypeUser();
                          print("CurrentUserProfile: ${typeUser}");
                          currentUserProvider.setProfile(typeUser);
                          if (selectCauseId != null &&
                              titleController.value.text.isNotEmpty) {

                            if (currentUserProvider.profile ==
                                KTypeUser.organization) {
                              Map<String, dynamic> assignmentMap = {
                                "title": titleController.value.text,
                                "description": descriptionController.value.text,
                                "deleted": false,
                                "descriptionNeeds": needController.value.text,
                                "descriptionResources":
                                    resourceController.value.text,
                              };

                              String assignmentId =
                                  await activityService.createAssignment(
                                      currentUserProvider
                                          .currentOrganization!.organizationId!,
                                      selectCauseId!,
                                      assignmentMap);
                              if (context.mounted) {
                                successDonation(context);
                              }
                            }
                          }
                        } catch (e) {
                          btnStateController.update(AsyncBtnState.success);
                          if (context.mounted) {
                            errorDonation(context);
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
                    successStyle: null,
                    /*
                    AsyncBtnStateStyle(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        foregroundColor: Colors.white,
                      ),
                      widget: const Row(
                        children: [
                          Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                          SizedBox(width: 4),
                          Text('Success!',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20))
                        ],
                      ),
                    )
                     */
                    failureStyle: AsyncBtnStateStyle(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      widget: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error,
                            color: Colors.white,
                          ),
                          SizedBox(width: 4),
                          Text('Erreur !',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                        ],
                      ),
                    ),
                    child: const Text('Continuer',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  ),
                ),

                // ========================Fin de la gestion du bouton asynchrone====================
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void successDonation(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      titleTextStyle:
          GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 24),
      descTextStyle: GoogleFonts.inter(fontSize: 16),
      headerAnimationLoop: false,
      title: 'Succès',
      desc: 'Vôtre mission a bien été crée',
      btnOkOnPress: () {},
      btnOkIcon: Icons.check_circle,
      btnOkColor: Colors.green,
    ).show();
  }

  void errorDonation(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      titleTextStyle:
      GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 24),
      descTextStyle: GoogleFonts.inter(fontSize: 16),
      headerAnimationLoop: false,
      title: 'Echec',
      desc: "La mission n'a pas pu être crée",
      btnOkOnPress: () {},
      btnOkIcon: Icons.cancel,
      btnOkColor: Colors.red,
    ).show();
  }
}
