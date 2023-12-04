import 'package:deme/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../models/assignment.dart';

class AssignmentCard extends StatelessWidget {
  const AssignmentCard({super.key, required this.assignment, this.onTap,});
  final Future<Assignment> assignment;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: assignment,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return InkWell(
            onTap: onTap,
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
              width: 180,
              decoration: BoxDecoration (
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage (
                  fit: BoxFit.cover,
                  image: NetworkImage (
                    snapshot.data!.cause.imageUrl,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    // group6Gpr (I10:266;10:262)
                    width: double.infinity,
                    height: 40,
                    decoration: const BoxDecoration (
                      color: Color(0xc6000000),
                      borderRadius: BorderRadius.only (
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        snapshot.data!.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            height: 1.2125,
                            overflow: TextOverflow.ellipsis
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        else if(snapshot.connectionState == ConnectionState.waiting){
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            enabled: true,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 80),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.grey
              ),
            ),
          );
        }
        else{
          return const SizedBox();
        }
      },

    );
  }
}