import 'package:async_button/async_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deme/models/cause.dart';
import 'package:deme/provider/change_log_screen_provider.dart';
import 'package:deme/provider/type_user_log_up_provider.dart';
import 'package:deme/services/cause_service.dart';
import 'package:deme/services/organization_service.dart';
import 'package:deme/services/shared_preferences_service.dart';
import 'package:deme/widgets/cause_card.dart';
import 'package:deme/widgets/checkbox_list_title_custom.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants.dart';
import '../../../main_screen.dart';
import '../../../models/method_payment.dart';
import '../../../provider/current_user_provider.dart';
import '../../../services/user_service.dart';
import '../../../size_config.dart';
import '../../../utils.dart';
import '../../../widgets/cause_radio_card.dart';
import '../../../widgets/next_button.dart';
import '../../../widgets/text_navigator.dart';
import 'add_demand.dart';

class ChooseCause extends StatefulWidget {
  const ChooseCause({super.key});

  @override
  State<ChooseCause> createState() => _ChooseCauseState();
}

class _ChooseCauseState extends State<ChooseCause> {

  //late Future<List<Cause>> futureCause;
  //CauseService causeService = CauseService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //futureCause = causeService.getAllCause();
  }
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final Stream<QuerySnapshot> causeStream = db.collection('causes').snapshots();

    //double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Demander un don"),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: double.infinity,
        child: Column(
          children: [
            const Text("Pour quel cause souhaitez-vous avoir un don ?",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
            const SizedBox(height: 5,),
            Expanded(
              child: StreamBuilder(
                stream: causeStream,
                builder: (context, snapshot) {
                  return (snapshot.hasData)?
                  GridView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final cause = Cause.getFromSnapshotDoc(snapshot.data?.docs[index]);
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: CauseCard(
                            cause: Future.value(cause),
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => AddDemand()));
                            },
                          ),
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
                  ):
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    enabled: true,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 80),
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: Colors.grey
                              ),
                            ),
                          ],
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*
  Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 100, horizontal: 100),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey
                                ),
                              ),
                            ],
                          )
   */
}
