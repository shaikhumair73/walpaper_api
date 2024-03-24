import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as httpClient;

import 'package:walpaper_api/UI_pages/search_Screen.dart';
import 'package:walpaper_api/UI_pages/wallpaperDetailPage.dart';
import 'package:walpaper_api/categoryModel.dart';
import 'package:walpaper_api/colorModel.dart';
import 'package:walpaper_api/datasource/remote/apihelperclass.dart';
import 'package:walpaper_api/model.dart';

import 'package:walpaper_api/search_bloc/search_walpaper_bloc.dart';
import 'package:walpaper_api/trend_bloc/walpaper_bloc.dart';
import 'package:walpaper_api/trend_bloc/walpaper_event.dart';
import 'package:walpaper_api/trend_bloc/walpaper_state.dart';

class My_Page extends StatefulWidget {
  const My_Page({super.key});

  @override
  State<My_Page> createState() => _My_PageState();
}

class _My_PageState extends State<My_Page> {
  Future<FinalModel?>? data;
  FinalModel? dataModel;
  FinalModel? trendModel;
  var controler = TextEditingController();
  List<Category> categoryData = [
    Category(
        title: "winter",
        imgPath:
            "https://www.pixelstalk.net/wp-content/uploads/2015/12/Download-free-high-definition-winter-backgrounds.jpg"),
    Category(
        title: "summer",
        imgPath:
            "https://tse3.mm.bing.net/th?id=OIP.tOE8fFSjw9v6U9d-BWp0MAHaEK&pid=Api&P=0&h=220"),
    Category(title: "car", imgPath: "https://wallpapercave.com/wp/Ne7y6MU.jpg"),
    Category(
        title: "bike",
        imgPath:
            "https://2.bp.blogspot.com/-sMgyn4C1Nwk/Umkh6ZhjcPI/AAAAAAAAOUE/8i-hWBw7HP0/s1600/BMW+S1000RR+world%2527s+fastest+bike+HD+wallpapers+Image01.jpg"),
    Category(
        title: "sea", imgPath: "https://wallpaperaccess.com/full/860435.jpg"),
    Category(
        title: "cloud",
        imgPath:
            "https://tse4.mm.bing.net/th?id=OIP.jI-tSZuavj9WsEW5IHcxAAHaE8&pid=Api&P=0&h=220"),
    Category(
        title: "flower",
        imgPath:
            "https://tse1.mm.bing.net/th?id=OIP.i2zI7vDSAhmyBpO5jt1AQwHaFj&pid=Api&P=0&h=220"),
    Category(
        title: "house",
        imgPath:
            "https://tse2.mm.bing.net/th?id=OIP.qOhLUJ0bLLTCEk0aOI5IPwHaFj&pid=Api&P=0&h=220"),
  ];
  List<Model1> listdata = [
    Model1(colorCode: "ffffff", colorValue: Colors.white24),
    Model1(colorCode: "000000", colorValue: Colors.black),
    Model1(colorCode: "0000ff", colorValue: Colors.blue),
    Model1(colorCode: "00ff00", colorValue: Colors.green),
    Model1(colorCode: "ff0000", colorValue: Colors.red),
    Model1(colorCode: "9C27B0", colorValue: Colors.purple),
    Model1(colorCode: "FF9800", colorValue: Colors.orange),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Future<FinalModel?>?data;

    //getWalpaper();
    //getTrendingWalpaper();
    BlocProvider.of<SearchWalpaperBloc>(context).add(Get_search_wal(
        queryy:
            controler.text.isNotEmpty ? controler.text.toString() : "nature"));

    BlocProvider.of<WalpaperBloc>(context).add(GetTrendWalpaper());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "wallpaper",
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
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 1,
                  child: TextField(
                      controller: controler,
                      decoration: InputDecoration(
                          suffix: TextButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Screen(
                                    search: controler.text.isNotEmpty
                                        ? controler.text.toString()
                                        : "nature",
                                    colorCode: null,
                                  );
                                }));
                              },
                              child: Text("enter")),
                          //icon: Icon(Icons.search),
                          hintText: "search wallpaper",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.white24),
                          ))),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 200.0),
                child: Text(
                  "best of month",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              //best of month
              Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  //color: Colors.grey,
                  //trend Walpaper
                  child: BlocBuilder<WalpaperBloc, WalpaperState>(
                    builder: (context, state) {
                      if (state is WalpaperLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is WalpaperError) {
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
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return WalpaperPage(
                                          Wallurl: trendModel!
                                              .photos![index].src!.portrait!);
                                    }));
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        "${data.src!.portrait}",
                                        fit: BoxFit.fill,
                                      ),
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
                height: MediaQuery.of(context).size.height * 0.02,
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.09,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: listdata.length,
                    itemBuilder: (cotext, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Screen(
                                search: controler.text.toString().isNotEmpty
                                    ? controler.text.toString()
                                    : "nature",
                                colorCode: listdata[index].colorCode,
                              );
                            }));
                          },
                          child: Container(
                            width: 65,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.grey),
                                color: listdata[index].colorValue),
                          ),
                        ),
                      );
                    }),
              ),

              //search walpaper
              Padding(
                padding: const EdgeInsets.only(right: 240),
                child: Text(
                  "category",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 9 / 11),
                  itemCount: categoryData.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Screen(
                                  search: categoryData[index].title,
                                  colorCode: null);
                            }));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.greenAccent,
                                image: DecorationImage(
                                    image: NetworkImage(
                                      "${categoryData[index].imgPath}",
                                    ),
                                    fit: BoxFit.fill)),
                            child: Center(
                                child: Text(
                              "${categoryData[index].title}",
                              style: TextStyle(
                                  fontSize: 22, fontStyle: FontStyle.italic),
                            )),
                          ),
                        ),
                      ),
                    );
                  }),
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
