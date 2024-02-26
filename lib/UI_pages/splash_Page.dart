import 'dart:async';

import 'package:flutter/material.dart';
import 'package:walpaper_api/UI_pages/UI_using_bloc.dart';
import 'package:walpaper_api/UI_pages/UI_using_future_builder.dart';
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
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              "assets/images/pexels-irina-iriser-1590549.jpg", fit: BoxFit.fill,

              // width: 150,
              // height: 200,
            ),
          ),
          Center(
              child: Text(
            "walpaper app",
            style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ))
        ],
      ),
    );
  }
}
