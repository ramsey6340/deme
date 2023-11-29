import 'package:async_button/async_button.dart';
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

class InitPreferredCause extends StatefulWidget {
  const InitPreferredCause({super.key});

  @override
  State<InitPreferredCause> createState() => _Body4State();
}

class _Body4State extends State<InitPreferredCause> {

  late Future<List<Cause>> futureCause;
  CauseService causeService = CauseService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureCause = causeService.getAllCause();
  }
  @override
  Widget build(BuildContext context) {

    double fem = MediaQuery.of(context).size.width / baseWidth;
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                      future: futureCause,
                      builder: (context, snapshot) {
                        return (snapshot.hasData)?
                        GridView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            final cause = snapshot.data![index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: CauseCard(
                                cause: cause,
                                onTap: (){
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => AddDemand()));
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
                        ):
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          enabled: true,
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 100, horizontal: 100),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.grey
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
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
