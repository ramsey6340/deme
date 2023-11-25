import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class ProfileImg extends StatelessWidget {
  const ProfileImg({
    Key? key,
    required this.profileImg,
    this.pressShowImg,
    this.pressModifImg,
    this.showIconAction=false,
    this.iconMinimal=Icons.camera_alt,
    this.iconMinimalColor=Colors.black,
    this.iconMinimalSize=30,
    this.backgroundIconMinimal=const Color(0xFFF5F6F9),
    this.radiusSize=70,
    this.isNetworkImg=true
  }) : super(key: key);
  final String profileImg;
  final Function()? pressShowImg;
  final Function()? pressModifImg;
  final bool showIconAction;
  final IconData iconMinimal;
  final Color iconMinimalColor;
  final Color backgroundIconMinimal;
  final double iconMinimalSize;
  final double radiusSize;
  final bool isNetworkImg;

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          (isNetworkImg)?GestureDetector(
            onTap: pressShowImg,
            child: CircleAvatar(
              radius: radiusSize,
              backgroundImage: NetworkImage(profileImg),
            ),
          ):GestureDetector(
            onTap: pressShowImg,
            child: CircleAvatar(
              radius: radiusSize,
              backgroundImage: AssetImage(profileImg),
            ),
          ),
          Positioned(
            bottom: 12,
            right: 0,
            child: GestureDetector(
              onTap: pressModifImg,
              child: (showIconAction)?Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: backgroundIconMinimal,
                  shape: BoxShape.circle,
                ),
                child: Icon(iconMinimal, color: iconMinimalColor, size: iconMinimalSize,),
              ):null,
            ),
          )
        ]
    );
  }
}