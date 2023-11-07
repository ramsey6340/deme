import 'package:deme/widgets/title_placeholder.dart';
import 'package:flutter/material.dart';

class PostShimmer extends StatelessWidget {
  const PostShimmer({super.key});

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
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 25,
                ),
                SizedBox(width: 8,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitlePlaceholder(width: 100,),
                    SizedBox(height: 5),
                    TitlePlaceholder(width: 150,),
                    SizedBox(height: 5),
                    TitlePlaceholder(width: 200,),
                    SizedBox(height: 5),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(''),
                      )),
                ),
                const SizedBox(height: 10,),
                const TitlePlaceholder(width: 200)
              ],
            ),
            const SizedBox(height: 15),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TitlePlaceholder(width: 50),
                SizedBox(width: 10,),
                TitlePlaceholder(width: 50),
                SizedBox(width: 10,),
                TitlePlaceholder(width: 50)
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
