import 'package:deme/constants.dart';
import 'package:deme/size_config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostContainer extends StatefulWidget {
  const PostContainer({super.key});
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
            bottom: BorderSide(color: Colors.black.withOpacity(0.5), width: 0.5)
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('assets/data_test/avatar.png'),
                ),
                SizedBox(width: getProportionateScreenWidth(8),),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'UNHCR',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Aidons Gao fasse aux terroristes',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            (imageEmpty)
                ? const SizedBox.shrink()
                : Column(
              children: [
                const SizedBox(height: 15),
                Container(
                  height: getProportionateScreenHeight(200),
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/data_test/education.png'),
                      )),
                ),
                const SizedBox(height: 10,),
                const Text("Un réfugié quitte son pays non pas parce qu'il le veut, mais parce qu'il le faut. Il ne devrait jamais être nécessaire de devenir un réfugié...")
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
                SizedBox(width: getProportionateScreenWidth(10),),
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
                SizedBox(width: getProportionateScreenWidth(10),),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? Colors.blue : Colors.black,
                      ),
                      onPressed: () {},
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
