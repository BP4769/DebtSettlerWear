import 'package:flutter/material.dart';

class AmbientWatchFace extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.black,
    body: Center(
        child: Image.asset("assets/splash_icon_circle.png", height: 130,)
    ),
  );
}