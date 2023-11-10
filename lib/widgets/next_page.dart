import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class NextPage extends StatelessWidget {
  const NextPage({
    Key? key, 
    required this.title, 
    required this.press, 
    required this.leading, 
    this.enable=true, 
    this.trailing=const Icon(Icons.navigate_next, size: 30,),
    this.backgroundColor=Colors.transparent,
    this.borderRadius=5
  }) : super(key: key);
  
  final String title;
  final Widget? leading;
  final Widget? trailing;
  final Function press;
  final bool enable;
  final Color backgroundColor;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(),
        borderRadius: BorderRadius.all(Radius.circular(borderRadius))
      ),
      child: ListTile(
        onTap: press as void Function(),
        leading: leading,
        title: Text(
            title,
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 20
            ), overflow: TextOverflow.ellipsis),
        enabled: enable,
        trailing: (enable)? trailing : null,
      ),
    );
  }
}