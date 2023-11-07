import 'package:deme/constants.dart';
import 'package:deme/models/method_payment.dart';
import 'package:deme/services/method_payment_service.dart';
import 'package:deme/size_config.dart';
import 'package:deme/widgets/next_button.dart';
import 'package:deme/widgets/text_form_field_custom.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FinancialPage extends StatefulWidget {
  const FinancialPage({super.key});

  @override
  State<FinancialPage> createState() => _FinancialPageState();
}

class _FinancialPageState extends State<FinancialPage> {
  late Future<List<MethodPayment>> futureMethodPayment;
  MethodPaymentService methodPaymentService = MethodPaymentService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureMethodPayment = methodPaymentService.getAllMethodPayment();
  }

  TextEditingController textEditingController = TextEditingController();
  final List<String> genderItems = [
    'Male',
    'Female',
  ];

  String? selectedValue;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: formKey,
        child: ListView(
          children: [
            SizedBox(height: getProportionateScreenHeight(40),),
            Text("Vous faite don de ", style: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 20),),
            SizedBox(height: getProportionateScreenHeight(20),),
            Container(
              padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
                  child: TextField(
                    controller: textEditingController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    cursorColor: kPrimaryColor,
                    style: GoogleFonts.inter(fontSize: 36, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      hintText: "Montant",
                      hintStyle: GoogleFonts.inter(fontWeight: FontWeight.normal, fontSize: 24),
                      suffixIcon: Text("fcfa", style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold, color: kPrimaryColor), textAlign: TextAlign.center,),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0), // Personnalisez la couleur et l'épaisseur ici
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0), // Personnalisez la couleur et l'épaisseur ici
                      ),
                    ),
                  )
            ),
            SizedBox(height: getProportionateScreenHeight(80),),
            Text("Mode de paiement", style: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 20),),
            SizedBox(height: getProportionateScreenHeight(10),),
            FutureBuilder(
              future: futureMethodPayment,
              builder: (context, snapshot) {
                return DropdownButtonFormField2<MethodPayment>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    // Add more decoration..
                  ),
                  hint: (snapshot.hasData)?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(backgroundImage: AssetImage(snapshot.data![0].imageUrl), radius: 20,),
                      Text(snapshot.data![0].name, style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w500),),
                    ],
                  ):const Text("Choisissez un mode de paiement"),
                  items: (snapshot.hasData)?snapshot.data
                      ?.map((methodPayment) => DropdownMenuItem<MethodPayment>(
                    value: methodPayment,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(backgroundImage: AssetImage(methodPayment.imageUrl), radius: 20,),
                        const SizedBox(width: 10,),
                        Text(methodPayment.name, style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w500),),
                      ],
                    ),
                  ))
                      .toList():[],
                  validator: (value) {
                    if (value == null) {
                      return 'Choisisser un mode de paiement';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    //Do something when selected item is changed.
                  },
                  onSaved: (value) {
                    selectedValue = value.toString();
                  },
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.only(right: 16),
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      size: 30,
                      color: Colors.black,
                    ),
                    iconSize: 24,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                );
              },
            ),
            SizedBox(height: getProportionateScreenHeight(40),),
            NextButton(text: 'Valider', press: (){}),
          ],
        ),
      ),
    );
  }
}
