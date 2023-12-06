import 'package:flutter/material.dart';
import 'body.dart';

class ListFinancialDonation extends StatelessWidget {
  const ListFinancialDonation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Donations"),
      ),

      body: Body(),
    );
  }
}
