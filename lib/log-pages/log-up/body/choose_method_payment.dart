import 'package:async_button/async_button.dart';
import 'package:deme/provider/current_user_provider.dart';
import 'package:deme/services/organization_service.dart';
import 'package:deme/services/payment_service.dart';
import 'package:deme/services/user_service.dart';
import 'package:deme/widgets/checkbox_list_title_custom.dart';
import 'package:deme/widgets/text_navigator.dart';
import 'package:deme/widgets/title_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants.dart';
import '../../../models/method_payment.dart';
import '../../../provider/change_log_screen_provider.dart';
import '../../../size_config.dart';
import '../../../widgets/next_button.dart';

class ChooseMethodPayment extends StatefulWidget {
  const ChooseMethodPayment({super.key});

  @override
  State<ChooseMethodPayment> createState() => _ChooseMethodPaymentState();
}

class _ChooseMethodPaymentState extends State<ChooseMethodPayment> {

  AsyncBtnStatesController btnStateController = AsyncBtnStatesController();

  List<bool> methodPayments = List.generate(13, (index) => false);
  PaymentService paymentService = PaymentService();
  late Future<List<MethodPayment>> futurePayment;
  UserService userService = UserService();
  OrganizationService organizationService = OrganizationService();

  @override
  void initState() {
    super.initState();
    futurePayment = paymentService.getAllMethodPayment();
  }


  @override
  Widget build(BuildContext context) {
    final changeLogScreen = Provider.of<ChangeLogScreenProvider>(context);
    final currentUserProvider = Provider.of<CurrentUserProvider>(context);

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
                    child: FutureBuilder(
                      future: futurePayment,
                      builder: (context, snapshot) {
                        return (snapshot.hasData)?ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            final methodPayment = snapshot.data![index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: CheckboxListTileCustom(
                                  checkBoxValue: currentUserProvider.currentUser!.preferredPaymentMethods.contains(methodPayment.methodPaymentId),
                                  onChangedCheckValue: (value) {
                                    setState(() {
                                      if(value==true){
                                        currentUserProvider.addMethodPayment(methodPayment.methodPaymentId);
                                      }
                                      else if(value==false){
                                        currentUserProvider.removeMethodePayment(methodPayment.methodPaymentId);
                                      }
                                    });
                                  },
                                  title: methodPayment.name,
                                  imageUrl: methodPayment.imageUrl),
                            );
                          },
                        ):
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          enabled: true,
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return const Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        CircleAvatar(radius: 20,),
                                        TitlePlaceholder(width: 200),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),

                  // ========================Gestion du bouton asynchrone====================
                  Center(
                    child: AsyncTextBtn(
                      style: kStyleNextBtn,

                      asyncBtnStatesController: btnStateController,
                      onPressed: () async {
                        btnStateController.update(AsyncBtnState.loading);

                        try {
                          if(currentUserProvider.profile == kTypeUser.user.toString()){
                            final currentUser = currentUserProvider.currentUser;
                            if(currentUser != null){
                              userService.patchUserInfo(
                                  currentUser.userId!,
                                  {"preferredPaymentMethods": currentUser.preferredPaymentMethods}
                              ).then((value) {
                                changeLogScreen.incrementIndex();
                                btnStateController.update(AsyncBtnState.success);

                              }).catchError((onError){
                                print(onError);
                                btnStateController.update(AsyncBtnState.failure);
                              });
                            }
                          }

                          // S'il s'agit d'une organisation
                          else if(currentUserProvider.profile == kTypeUser.organization.toString()) {
                            final currentOragnization = currentUserProvider.currentOrganization;
                            if(currentOragnization != null){
                              organizationService.patchOrganizationInfo(
                                  currentOragnization.organizationId!,
                                  {"preferredPaymentMethods": currentOragnization.preferredPaymentMethods}
                              ).then((value) {
                                changeLogScreen.incrementIndex();
                                btnStateController.update(AsyncBtnState.success);

                              }).catchError((onError){
                                print(onError);
                                btnStateController.update(AsyncBtnState.failure);
                              });
                            }
                          }

                        } catch (e) {
                          btnStateController.update(AsyncBtnState.failure);
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
