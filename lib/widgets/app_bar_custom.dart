import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget{
  const AppBarCustom({
    super.key,
    this.appBarHeight=50,
    required this.title,
    this.leadingIconData=Icons.account_circle_rounded,
    this.trailingIconData=Icons.map,
    required this.onLeadingPress,
    required this.onTrailingPress,
  });

  final double appBarHeight;
  final String title;
  final IconData leadingIconData;
  final IconData trailingIconData;
  final void Function() onLeadingPress;
  final void Function() onTrailingPress;

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.white,
      bottom: PreferredSize(
        preferredSize: preferredSize,
        child: Container(color: Colors.black.withOpacity(0.5), height: 1,),
      ),
      centerTitle: true,
      title: Text(title, style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w400), overflow: TextOverflow.ellipsis,),
      leading: IconButton(icon: Icon(leadingIconData), onPressed: onLeadingPress,),
      actions: [
        IconButton(icon: Icon(trailingIconData), onPressed: onTrailingPress,),
      ],
    );
  }
}