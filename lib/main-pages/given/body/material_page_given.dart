import 'package:deme/data-test/data_test.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../widgets/address_card.dart';
import '../../../widgets/next_button.dart';

class MaterialPageGiven extends StatefulWidget {
  const MaterialPageGiven({super.key});

  @override
  State<MaterialPageGiven> createState() => _MaterialPageGivenState();
}

class _MaterialPageGivenState extends State<MaterialPageGiven> {
  bool isSuccess = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: (isSuccess)?successDonationPage():descriptionDonationPage(),
      ),
    );
  }


  Widget descriptionDonationPage() {
    return Column(
      children: [
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.multiline,
            maxLines: null, // Permet un nombre dynamique de lignes
            expands: true,
            decoration: const InputDecoration(
              hintText: 'Décrivez précisément les dons matériels que \nvous souhaitez faire',
            ),
          ),
        ),
        NextButton(text: 'Valider', press: () {
          setState(() {
            isSuccess=true;
          });
        },
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width*0.3)),
        SizedBox(height: 10,)
      ],
    );
  }

  Widget successDonationPage() {
    return ListView(
      children: [
        Text("Il reste encore un pas",
          style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        const Icon(Icons.check_circle, color: Colors.green, size: 150,),
        Text("Pour completer vôtre donation vous devez livrer le materiel "
            "à l’adresse situer ci-dessous.",
          style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10,),
        AddressCard(
          titleAddress: 'Sourions à l’espoire',
          numTel: '(+223) 89 09 12 34',
          address: addresses[0],
          onTapAddress: (){},
        ),
        const SizedBox(height: 40,),
        NextButton(text: 'Terminer', press: () {
          setState(() {
            isSuccess=false;
          });
        },
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width*0.3, vertical: 10)),
      ],
    );
  }
}
