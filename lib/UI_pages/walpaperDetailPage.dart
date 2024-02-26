import 'package:flutter/material.dart';

class WalpaperPage extends StatelessWidget {
  String Wallurl;
  WalpaperPage({required this.Wallurl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("walpaper"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Image.network(
          Wallurl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
