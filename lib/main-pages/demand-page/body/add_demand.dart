import 'package:async_button/async_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../provider/current_user_provider.dart';

class AddDemand extends StatefulWidget {
  const AddDemand({super.key});

  @override
  State<AddDemand> createState() => _AddDemandState();
}

class _AddDemandState extends State<AddDemand> {
  AsyncBtnStatesController btnStateController = AsyncBtnStatesController();

  final formKey = GlobalKey<FormState>();
  TextEditingController descriptionEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final currentUserProvider = Provider.of<CurrentUserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 20,
        leading: SizedBox(),
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
                  TextButton(onPressed: (){}, child: Icon(Icons.arrow_back, color: Colors.black,)),

                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: kPrimaryColor
                    ),
                    onPressed: () {  },
                    child: Text("Poster", style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
              Expanded(
                child: TextFormField(
                  controller: descriptionEditingController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null, // Permet un nombre dynamique de lignes
                  expands: true,
                  decoration: const InputDecoration(
                    hintText: 'Decrivez précisement votre problème et votre \nbesoin pour la cause education',
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
              ),

              // ========================Fin de la gestion du bouton asynchrone====================

              const SizedBox(height: 10,)
            ],
          ),
        ),
      ),
    );
  }
}
