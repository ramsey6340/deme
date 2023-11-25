import 'package:deme/constants.dart';
import 'package:deme/size_config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/post.dart';

class PostContainer extends StatefulWidget {
  const PostContainer({super.key, required this.post});
  final Post post;

  @override
  State<PostContainer> createState() => _PostContainerState();
}

class _PostContainerState extends State<PostContainer> {
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
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      widget.post.activity.assignment.organization.imageUrl!),
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
                              widget.post.activity.assignment.organization.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            overflow: TextOverflow.ellipsis,
                          ),
                          children: [
                            TextSpan(
                                text:
                                    '\n@${widget.post.activity.assignment.cause.name.toLowerCase()}',
                                style: GoogleFonts.workSans(
                                    fontSize: 12, color: kPrimaryColor))
                          ]),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.post.activity.title,
                      style: GoogleFonts.workSans(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (widget.post.imageUrls.isNotEmpty && widget.post.imageUrls[0].isNotEmpty)?const SizedBox(height: 15):SizedBox(),
                      (widget.post.imageUrls.isNotEmpty && widget.post.imageUrls[0].isNotEmpty)?
                      Container(
                        height: (widget.post.imageUrls.isNotEmpty)?getProportionateScreenHeight(200):0,
                        width: double.infinity,
                        decoration: (widget.post.imageUrls.isNotEmpty)?BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(10),
                            image:  DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(widget.post.imageUrls[0]),
                            )):BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(10)),
                      ):SizedBox(),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.post.message,
                        style: GoogleFonts.workSans(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.start,
                      )
                    ],
                  ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
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
                  width: getProportionateScreenWidth(10),
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
                  width: getProportionateScreenWidth(10),
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
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
