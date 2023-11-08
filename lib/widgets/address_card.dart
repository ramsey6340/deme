import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/address.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({super.key, required this.titleAddress, required this.address, this.numTel, this.onTapAddress});
  final String titleAddress;
  final String? numTel;
  final Address address;
  final void Function()? onTapAddress;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 428;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return InkWell(
      onTap: onTapAddress,
      child: Container(
        padding: EdgeInsets.fromLTRB(13*fem, 7*fem, 13*fem, 7*fem),
        width: double.infinity,
        height: 98*fem,
        decoration: BoxDecoration (
          color: Colors.white,
          borderRadius: BorderRadius.circular(5*fem),
          boxShadow: [
            BoxShadow(
              color: const Color(0x3f000000),
              offset: Offset(0*fem, 0*fem),
              blurRadius: 2*fem,
            ),
          ],
        ),
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 5*fem, 0*fem),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10*fem),
                  child: Image.asset(
                    'assets/images/map.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(0*fem, 12*fem, 0*fem, 11*fem),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 4*fem),
                        width: double.infinity,
                        child: Text(
                          titleAddress,
                          style: GoogleFonts.inter(
                            fontSize: 16*ffem,
                            fontWeight: FontWeight.w600,
                            height: 1.2125*ffem/fem,
                          ),
                        ),
                      ),
                      (numTel!=null)?Container(
                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 5*fem),
                        child: Text(
                          numTel!,
                          style: GoogleFonts.inter(
                            fontSize: 14*ffem,
                            fontWeight: FontWeight.w500,
                            height: 1.2125*ffem/fem,
                          ),
                        ),
                      ):const SizedBox(),
                      Text(
                        '${address.city}, ${address.neighborhood}',
                        style: GoogleFonts.inter(
                          fontSize: 14*ffem,
                          fontWeight: FontWeight.w500,
                          height: 1.2125*ffem/fem,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
