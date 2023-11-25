import 'package:deme/constants.dart';
import 'package:deme/size_config.dart';
import 'package:deme/widgets/next_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/demand.dart';
import '../models/post.dart';

class DemandContainer extends StatefulWidget {
  const DemandContainer({super.key, required this.demand});
  final Demand demand;

  @override
  State<DemandContainer> createState() => _DemandContainerState();
}

class _DemandContainerState extends State<DemandContainer> {
  int likesCount = 0;
  bool isLiked = false;
  bool imageEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: Colors.black.withOpacity(0.5), width: 0.5))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                (widget.demand.organization != null)?
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      widget.demand.organization!.imageUrl!),
                ):CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      widget.demand.user!.imageUrl!),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(8),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                          text:
                          (widget.demand.organization != null)?
                          widget.demand.organization?.name:
                          widget.demand.user?.name,
                          style: GoogleFonts.workSans(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                                text:
                                '\n@${widget.demand.cause.name.toLowerCase()}',
                                style: GoogleFonts.workSans(
                                    fontSize: 12, color: kPrimaryColor))
                          ]),
                    ),
                    SizedBox(height: 5),
                    Text.rich(
                     TextSpan(text: 'Garantie par ',
                       children: [
                         TextSpan(text: '@${widget.demand.guarantor.login}',
                             style: const TextStyle(
                                 fontFamily: 'Inter',
                               color: kPrimaryColor,
                               overflow: TextOverflow.ellipsis
                             ),
                         )
                       ]
                     ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                (widget.demand.imageUrl != null && widget.demand.imageUrl!.isNotEmpty)?
                Container(
                  height: getProportionateScreenHeight(200),
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(10),
                      image:  DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.demand.imageUrl!),
                      )),
                ):SizedBox(),
                const SizedBox(
                  height: 10,
                ),
                (widget.demand.description!.isNotEmpty && widget.demand.description!=null)?
                Text(
                  widget.demand.description!,
                  style: GoogleFonts.workSans(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.start,
                ):SizedBox()
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const FaIcon(FontAwesomeIcons.comment),
                          onPressed: () {},
                        ),
                        Text(
                          '$likesCount',
                        ),
                      ],
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(5),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const FaIcon(FontAwesomeIcons.share),
                          onPressed: () {},
                        ),
                        Text(
                          '$likesCount',
                        ),
                      ],
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(5),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked ? kPrimaryColor : Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              isLiked = !isLiked;
                            });
                          },
                        ),
                        Text(
                          '$likesCount',
                        ),
                      ],
                    ),
                  ],
                ),

                //SizedBox(width: getProportionateScreenWidth(20),),
                NextButton(text: 'Faire un don',press: (){}),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
