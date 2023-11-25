import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/financial_donation.dart';

class FinancialDonationWidget extends StatefulWidget {
  const FinancialDonationWidget(
      {super.key, required this.financialDonation, this.onTapAddress});

  final FinancialDonation financialDonation;
  final void Function()? onTapAddress;
  @override
  State<FinancialDonationWidget> createState() =>
      _FinancialDonationWidgetState();
}

class _FinancialDonationWidgetState extends State<FinancialDonationWidget> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 428;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return InkWell(
      onTap: widget.onTapAddress,
      child: Container(
        padding: EdgeInsets.fromLTRB(13 * fem, 7 * fem, 13 * fem, 7 * fem),
        height: 98 * fem,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5 * fem),
          boxShadow: [
            BoxShadow(
              color: const Color(0x3f000000),
              offset: Offset(0 * fem, 0 * fem),
              blurRadius: 2 * fem,
            ),
          ],
        ),
        child: Expanded(
          child: Container(
            margin: EdgeInsets.fromLTRB(0 * fem, 12 * fem, 0 * fem, 11 * fem),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 4 * fem),
                      child: Text(
                        '${widget.financialDonation.amount} fcfa',
                        style: GoogleFonts.inter(
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.2125 * ffem / fem,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 5 * fem),
                      child: (widget.financialDonation.donorUser!=null)?
                      Text(
                        '@${widget.financialDonation.donorUser?.login}',
                        style: GoogleFonts.inter(
                          fontSize: 14 * ffem,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          height: 1.2125 * ffem / fem,
                        ),
                      ):Text(
                        '@${widget.financialDonation.donorOrganization?.login}',
                        style: GoogleFonts.inter(
                          fontSize: 14 * ffem,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          height: 1.2125 * ffem / fem,
                        ),
                      ),
                    ),
                    Text(
                      widget.financialDonation.creationDate!,
                      style: GoogleFonts.inter(
                        fontSize: 14 * ffem,
                        fontWeight: FontWeight.w500,
                        height: 1.2125 * ffem / fem,
                      ),
                    ),
                  ],
                ),
                Chip(
                    side: const BorderSide(
                      color: Colors.transparent,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    backgroundColor: (widget.financialDonation.used!)
                        ? Colors.green
                        : Colors.red,
                    label: Text(
                      (widget.financialDonation.used!)
                          ? "Utilisé"
                          : "Non utilisé",
                      style:
                          GoogleFonts.inter(color: Colors.white, fontSize: 10),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
