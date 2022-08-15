import 'package:debtsettler_wear/Zasloni/PrikazUporabnikovScreen.dart';
import 'package:debtsettler_wear/Zasloni/AmbientWatchFace.dart';
import 'package:debtsettler_wear/Zasloni/SeznamGospodinjstevScreen.dart';
import 'package:flutter/material.dart';
import 'package:wear/wear.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WatchScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WatchScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return WatchShape(
      builder: (BuildContext context, WearShape shape, Widget? child) {
        return AmbientMode(
          builder: (context, mode, child) {
            return mode == WearMode.active ? SeznamGospodinjstevScreen() : AmbientWatchFace();
          },
        );
      },
    );
  }
}


