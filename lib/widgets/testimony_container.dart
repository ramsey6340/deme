import 'package:deme/constants.dart';
import 'package:deme/models/testimony.dart';
import 'package:deme/size_config.dart';
import 'package:deme/widgets/post_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';



class TestimonyContainer extends StatefulWidget {
  const TestimonyContainer({super.key, required this.testimony});
  final Future<Testimony> testimony;

  @override
  State<TestimonyContainer> createState() => _TestimonyContainerState();
}

class _TestimonyContainerState extends State<TestimonyContainer> {
  int likesCount = 0;
  bool isLiked = false;
  bool imageEmpty = false;
  Testimony? testimony;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initTestimony();
  }
  void initTestimony()async {
    testimony = await widget.testimony;

  }

  @override
  Widget build(BuildContext context) {
    if(testimony != null){
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
                    backgroundImage: (testimony?.organization!=null)?
                    NetworkImage(testimony!.organization!.imageUrl!):
                    NetworkImage(testimony!.user!.imageUrl!),
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
                            (testimony!.organization!=null)?
                            testimony!.organization!.name:
                            testimony!.user!.login,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis,
                            ),
                            children: [
                              TextSpan(
                                  text:
                                  '\n@${testimony!.cause.name.toLowerCase()}',
                                  style: GoogleFonts.workSans(
                                      fontSize: 12, color: kPrimaryColor))
                            ]),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (testimony!.imageUrl!=null && testimony!.imageUrl!.isNotEmpty)?const SizedBox(height: 15):const SizedBox(),
                  (testimony!.imageUrl!=null && testimony!.imageUrl!.isNotEmpty)?Container(
                    height: getProportionateScreenHeight(200),
                    decoration: (BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(10),
                        image:  DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(testimony!.imageUrl!),
                        ))),
                  ):const SizedBox(),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    (testimony!.message!=null && testimony!.message!.isNotEmpty)?
                    testimony!.message!:'',
                    style: GoogleFonts.workSans(
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.start,
                  )
                ],
              ),
              const SizedBox(height: 15),
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
    else{
      return const Text("");
    }
  }
}
