import 'package:deme/constants.dart';
import 'package:deme/size_config.dart';
import 'package:deme/widgets/next_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../main-pages/given/body/give_to_demand/body_given_demand.dart';
import '../models/demand.dart';
import '../provider/global_value.dart';

class DemandContainer extends StatefulWidget {
  const DemandContainer({super.key, required this.demand});
  final Future<Demand> demand;

  @override
  State<DemandContainer> createState() => _DemandContainerState();
}

class _DemandContainerState extends State<DemandContainer> {
  int likesCount = 0;
  bool isLiked = false;
  bool imageEmpty = false;
  Demand? demand;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initDemand();
  }
  void initDemand()async {
    demand = await widget.demand;

  }

  @override
  Widget build(BuildContext context) {
    final globalValue = Provider.of<GlobalValue>(context);
    if(demand != null){
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Colors.black.withOpacity(0.5), width: 0.5))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  (demand?.organization != null)?
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                        demand!.organization!.imageUrl!),
                  ):CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                        demand!.user!.imageUrl!),
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(8),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                            text:
                            (demand!.organization != null)?
                            demand!.organization?.login:
                            demand!.user?.login,
                            style: GoogleFonts.workSans(
                              fontSize: 16, fontWeight: FontWeight.bold, ),
                            children: [
                              TextSpan(
                                  text:
                                  '\n@${demand!.cause.name.toLowerCase()}',
                                  style: GoogleFonts.workSans(
                                      fontSize: 12, color: kPrimaryColor))
                            ]),
                      ),
                      const SizedBox(height: 5),
                      Text.rich(
                        TextSpan(text: 'Garantie par ',
                            children: [
                              TextSpan(text: '@${demand!.guarantor.login}',
                                style: const TextStyle(
                                    fontFamily: 'Inter',
                                    color: kPrimaryColor,
                                    overflow: TextOverflow.ellipsis
                                ),
                              )
                            ]
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  (demand!.imageUrl != null && demand!.imageUrl!.isNotEmpty)?
                  Container(
                    height: getProportionateScreenHeight(200),
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(10),
                        image:  DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(demand!.imageUrl!),
                        )),
                  ):const SizedBox(),
                  const SizedBox(
                    height: 10,
                  ),
                  (demand!.description!.isNotEmpty && demand!.description!=null)?
                  Text(
                    demand!.description!,
                    style: GoogleFonts.workSans(
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.start,
                  ):const SizedBox()
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const FaIcon(FontAwesomeIcons.comment),
                            onPressed: () {},
                          ),
                          Text(
                            '$likesCount',
                          ),
                        ],
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(5),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const FaIcon(FontAwesomeIcons.share),
                            onPressed: () {},
                          ),
                          Text(
                            '$likesCount',
                          ),
                        ],
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(5),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              isLiked ? Icons.favorite : Icons.favorite_border,
                              color: isLiked ? kPrimaryColor : Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                isLiked = !isLiked;
                              });
                            },
                          ),
                          Text(
                            '$likesCount',
                          ),
                        ],
                      ),
                    ],
                  ),

                  //SizedBox(width: getProportionateScreenWidth(20),),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width*0.4,
                    child: NextButton(
                        text: 'Faire un don',
                        textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
                        press: (){
                          globalValue.setBeneficiaryDonation(BeneficiaryType.demand);
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => BodyGivenDemand(demand: demand!)));
                        }
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      );
    }
    else{
      return const Text("");
    }
  }
}
