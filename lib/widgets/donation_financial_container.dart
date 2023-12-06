import 'package:deme/models/financial_donation.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../utils.dart';

class DonationFinancialContainer extends StatelessWidget {
  const DonationFinancialContainer({super.key, required this.financialDonation});
  final Future<FinancialDonation> financialDonation;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: financialDonation,
        builder: (context, snapshot){
          if(snapshot.hasData){
            return Container(
              padding: const EdgeInsets.fromLTRB(17, 11, 9, 10),
              width: double.infinity,
              height: 74,
              decoration: BoxDecoration (
                color: const Color(0xffffffff),
                borderRadius: BorderRadius.circular(5),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x3f000000),
                    offset: Offset(0, 0),
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // frame432bk (I127:3404;127:3397)
                    margin: const EdgeInsets.fromLTRB(0, 0, 135, 0),
                    height: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 91,
                          height: 36,
                          child: Stack(
                            children: [
                              Positioned(
                                // fcfaH1t (I127:3404;127:3394)
                                left: 0,
                                top: 0,
                                child: Align(
                                  child: SizedBox(
                                    width: 91,
                                    height: 20,
                                    child: Text(
                                      '${snapshot.data!.amount}',
                                      textAlign: TextAlign.center,
                                      style: SafeGoogleFont (
                                        'Inter',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xff000000),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                // ousmanyQW (I127:3404;127:3395)
                                left: 0,
                                top: 19,
                                child: Align(
                                  child: SizedBox(
                                    width: 66,
                                    height: 17,
                                    child: Text(
                                      '@${snapshot.data!.donorOrganization?.login}',
                                      style: SafeGoogleFont (
                                        'Inter',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xff0077b5),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          // mardile12092023rz6 (I127:3404;127:3396)
                          '${snapshot.data!.creationDate}',
                          style: SafeGoogleFont (
                            'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff676666),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // group122Mfx (I127:3404;130:3562)
                    margin: const EdgeInsets.fromLTRB(0, 18, 0, 20),
                    padding: const EdgeInsets.fromLTRB(7, 2, 8, 0),
                    height: double.infinity,
                    decoration: BoxDecoration (
                      color: (snapshot.data!.used!)?Colors.green:const Color(0xffea2020),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      (snapshot.data!.used!)?'Utilisé':'Non utilisé',
                      textAlign: TextAlign.center,
                      style: SafeGoogleFont (
                        'Inter',
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xffffffff),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          else if(snapshot.connectionState == ConnectionState.waiting){
            return Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              enabled: true,
              child: Container(
                height: 100,
                width: MediaQuery.sizeOf(context).width*0.8,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey
                ),
              ),
            );
          }
          else{
            return const SizedBox();
          }
        }
    );
  }
}
