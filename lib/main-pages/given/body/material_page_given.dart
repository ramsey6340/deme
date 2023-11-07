import 'package:flutter/material.dart';

class MaterialPageGiven extends StatefulWidget {
  const MaterialPageGiven({super.key});

  @override
  State<MaterialPageGiven> createState() => _MaterialPageGivenState();
}

class _MaterialPageGivenState extends State<MaterialPageGiven> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Material Page"),);
  }
}
