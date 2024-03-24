import 'dart:async';

import 'package:flutter/material.dart';
import 'package:walpaper_api/UI_pages/UI_using_bloc.dart';

import 'package:walpaper_api/main.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return My_Page();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
            image:
                AssetImage("assets/images/pexels-tausif-hossain-1226302.jpg"),
            fit: BoxFit.fill,
          )),
          child: Center(
              child: Text(
            "HD Wallpaper",
            style: TextStyle(
                fontStyle: FontStyle.italic, fontSize: 50, color: Colors.white),
          ))),
    );
  }
}
