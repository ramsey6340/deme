import 'package:flutter/material.dart';

class LastActivity extends StatefulWidget {
  const LastActivity({super.key});

  @override
  State<LastActivity> createState() => _LastActivityState();
}

class _LastActivityState extends State<LastActivity> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Center(child: Text("Activité"),));
  }
}
