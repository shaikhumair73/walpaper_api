import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as httpClient;
import 'package:walpaper_api/bloc/walpaper_bloc.dart';
import 'package:walpaper_api/bloc/walpaper_event.dart';
import 'package:walpaper_api/bloc/walpaper_state.dart';
import 'package:walpaper_api/model.dart';

class My_Page extends StatefulWidget {
  const My_Page({super.key});

  @override
  State<My_Page> createState() => _My_PageState();
}

class _My_PageState extends State<My_Page> {
  FinalModel? dataModel;
  FinalModel? trendModel;
  var controler = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getWalpaper();
    //getTrendingWalpaper();
    //BlocProvider.of<WalpaperBloc>(context)
    //.add(GetSearchWalpaperEvent(query: "nature"));
    BlocProvider.of<WalpaperBloc>(context).add(GetTrendWalpaper());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "walpaper",
          style: TextStyle(fontSize: 28),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //textfeild
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  height: 60,
                  child: TextField(
                      controller: controler,
                      decoration: InputDecoration(
                          suffix: TextButton(
                              onPressed: () {}, child: Text("enter")),
                          //icon: Icon(Icons.search),
                          hintText: "search walpaper",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.white24),
                          ))),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 200.0),
                child: Text(
                  "best of month",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              //best of month
              Container(
                  height: 200,
                  //color: Colors.grey,
                  //trend Walpaper
                  child: BlocBuilder<WalpaperBloc, WalpaperState>(
                    builder: (context, state) {
                      /* if (state is WalpaperLoading) {
                        return CircularProgressIndicator();
                      } else

                      */
                      if (state is WalpaperError) {
                        return Text("error : ${state.error}");
                      } else if (state is WalpaperLoaded) {
                        trendModel = state.mData;

                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: trendModel!.photos!.length,
                            itemBuilder: (context, index) {
                              var data = trendModel!.photos![index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      "${data.src!.portrait}",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              );
                            });
                      }
                      return Container();
                    },
                  )),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 230.0),
                child: Text(
                  "Color Tone",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              //search walpaper
              BlocBuilder<WalpaperBloc, WalpaperState>(
                builder: (context, state) {
                  if (state is WalpaperLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is WalpaperError) {
                    return Text("error : ${state.error}");
                  } else if (state is WalpaperLoaded) {
                    dataModel = state.mData;
                    return GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            childAspectRatio: 9 / 16),
                        itemCount: dataModel!.photos!.length,
                        itemBuilder: (context, index) {
                          var img = dataModel!.photos![index].src!.portrait;
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Container(
                                  child: Image.network(
                                "$img",
                                fit: BoxFit.fill,
                              )),
                            ),
                          );
                        });
                  }
                  return Container();
                },
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /* void getTrendingWalpaper() async {
    // query = controler.text.toString();
    var mApiKey = "ZRjHE8i5lKPmRDg7sMi0RLE8E1dXJxXY2NpoNoyCgyhygj4Q5ZDd6znI";

    var uri = Uri.parse("https://api.pexels.com/v1/curated");
    var response =
        await httpClient.get(uri, headers: {"Authorization": mApiKey});
    if (response.statusCode == 200) {
      var rawData = jsonDecode(response.body);
      trendModel = FinalModel.fromJason(rawData);
      // dataModel = FinalModel.fromJason(rawData);
      setState(() {});
      print("status code trending ${response.statusCode}");
      print("body treding ${response.body}");
    }


  }

  */

  /*void getWalpaper({String query = "nature", String colorCode = ""}) async {
    // query = controler.text.toString();
    var mApiKey = "ZRjHE8i5lKPmRDg7sMi0RLE8E1dXJxXY2NpoNoyCgyhygj4Q5ZDd6znI";

    var uri = Uri.parse(
        "https://api.pexels.com/v1/search?query=$query&color=$colorCode");
    var response =
        await httpClient.get(uri, headers: {"Authorization": mApiKey});
    if (response.statusCode == 200) {
      var rawData = jsonDecode(response.body);
      dataModel = FinalModel.fromJason(rawData);
      setState(() {});
      // dataModel = FinalModel.fromJason(rawData);
      print(response.statusCode);
    }
  }

   */
}
