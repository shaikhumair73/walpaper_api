import 'dart:core';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:wallpaper/wallpaper.dart';
import 'package:walpaper_api/costumWidget/button.dart';

class WalpaperPage extends StatelessWidget {
  String Wallurl;
  WalpaperPage({required this.Wallurl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("wallpaper"),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.network(
              Wallurl,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  StackButton(
                      icon: Icon(
                        Icons.info,
                        size: 40,
                        color: Colors.white60,
                      ),
                      name: "info",
                      onPressed: () {}),
                  StackButton(
                      icon: Icon(
                        Icons.download,
                        size: 40,
                        color: Colors.white60,
                      ),
                      name: "download",
                      onPressed: () {
                        saveWalpaper(context);
                      }),
                  StackButton(
                      icon: Icon(
                        Icons.edit,
                        size: 40,
                        color: Colors.white60,
                      ),
                      name: "apply",
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 60.0),
                                child: AlertDialog(
                                  alignment: Alignment.bottomCenter,
                                  backgroundColor: Colors.white,
                                  content: SizedBox(
                                    height: 120,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        InkWell(
                                          child: Text(
                                            "Home screen",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          onTap: () {
                                            applyWalpaper(context, 1);
                                          },
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            applyWalpaper(context, 2);
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Lock screen",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            applyWalpaper(context, 3);
                                          },
                                          child: Text(
                                            " Home & Lock screen",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      }),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void applyWalpaper(BuildContext context, int flag) {
    var imgSream = Wallpaper.imageDownloadProgress(Wallurl);
    imgSream.listen((event) {
      print("Event $event");
    }, onDone: () async {
      if (flag == 1) {
        var check = await Wallpaper.homeScreen(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            options: RequestSizeOptions.RESIZE_FIT);
        print("result $check");
      } else if (flag == 2) {
        var check = await Wallpaper.lockScreen(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            options: RequestSizeOptions.RESIZE_FIT);
        print("result $check");
      } else if (flag == 3) {
        var check = await Wallpaper.homeScreen(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            options: RequestSizeOptions.RESIZE_FIT);
        var check1 = await Wallpaper.lockScreen(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            options: RequestSizeOptions.RESIZE_FIT);
        print("result $check");
        print("result $check1");
      }
    }, onError: (e) {
      print("error : $e");
    });
  }

  void saveWalpaper(BuildContext context) {
    GallerySaver.saveImage(Wallurl).then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Walpaper saved!")));
      print("Walpaper saved $value");
    });
  }
}
