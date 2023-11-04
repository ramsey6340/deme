import 'package:flutter/material.dart';


class ButtonChip extends StatelessWidget {
  const ButtonChip({
    Key? key,
    required this.press,
    required this.text,
    this.textColor = const Color(0xFF0077B5),
    this.backgroundColor = Colors.white,
    this.isSelected=false,
    this.leading,
    this.selectedBackground = const Color(0xFF0077B5),
    this.selectedTextColor = Colors.white,
    this.selectedLeading,
    this.isBorder=true,
  }) : super(key: key);

  final Function() press;
  final String text;
  final Color textColor;
  final Color selectedTextColor;
  final Color backgroundColor;
  final Color selectedBackground;
  final bool isSelected;
  final Widget? leading;
  final Widget? selectedLeading;
  final bool isBorder;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Chip(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        backgroundColor: (isSelected)? selectedBackground: backgroundColor,
        side: (isBorder)?BorderSide(color: (isSelected)?Colors.transparent: const Color(0xFF3F489C)):const BorderSide(color: Colors.transparent),
        label: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
        labelStyle: TextStyle(color: (isSelected)?selectedTextColor:textColor),
        avatar: (isSelected)? selectedLeading: leading,
      ),
    );
  }
}