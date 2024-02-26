import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as httpClient;
import 'package:walpaper_api/UI_pages/splash_Page.dart';
import 'package:walpaper_api/UI_pages/walpaperDetailPage.dart';
import 'package:walpaper_api/bloc/walpaper_bloc.dart';
import 'package:walpaper_api/colorModel.dart';
import 'package:walpaper_api/datasource/remote/apihelperclass.dart';
import 'package:walpaper_api/datasource/remote/urls.dart';
import 'package:walpaper_api/model.dart';

void main() {
  runApp(BlocProvider(
      create: (context) => WalpaperBloc(apiHelper: ApiHelper()),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  //const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: SplashPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Model1> mList = [
    Model1(colorCode: "ffffff", colorValue: Colors.white24),
    Model1(colorCode: "000000", colorValue: Colors.black),
    Model1(colorCode: "0000ff", colorValue: Colors.blue),
    Model1(colorCode: "00ff00", colorValue: Colors.green),
    Model1(colorCode: "ff0000", colorValue: Colors.red),
    Model1(colorCode: "9C27B0", colorValue: Colors.purple),
    Model1(colorCode: "FF9800", colorValue: Colors.orange),
  ];
  var controler = TextEditingController();
  Future<FinalModel?>? dataModel;
  Future<FinalModel?>? mTrendinData;
  FinalModel? dataModell;
  FinalModel? trendingModel;

  // get index => null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    dataModel = getWalpaper();
    mTrendinData = getTrendingWalpaper();

    // BlocProvider.of<WalpaperBloc>(context, listen: false)
    //.add(GetSearchWalpaperEvent(query: "${Url.Search_Url}?query=nature"));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("walpaper"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  height: 60,
                  child: TextField(
                      controller: controler,
                      decoration: InputDecoration(
                          suffix: TextButton(
                              onPressed: () {
                                dataModel = getWalpaper(
                                    query: controler.text.toString());
                                setState(() {});
                              },
                              child: Text("enter")),
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
              Container(
                  // margin: EdgeInsets.all(11),
                  height: 200,
                  //color: Colors.grey,

                  child: FutureBuilder<FinalModel?>(
                      future: mTrendinData!,
                      builder: (context, snapshot) {
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.photos!.length,
                            itemBuilder: (context, index) {
                              var eachPhoto =
                                  snapshot.data!.photos![index].src!.portrait!;
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    NavigateToDetailPage(snapshot
                                        .data!.photos![index].src!.portrait!);
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(11),
                                    child: Image.network(
                                      eachPhoto,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              );
                            });
                      })),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 230.0),
                child: Text(
                  "Color Tone",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 75,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: mList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            dataModel = getWalpaper(
                                query: controler.text.toString(),
                                colorCode: mList[index].colorCode!);
                            setState(() {});
                          },
                          child: Container(
                            // margin: EdgeInsets.all(10),
                            width: 75,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(11),
                                color: mList[index].colorValue,
                                border: Border.all(color: Colors.grey)),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 10,
              ),
              //blocbuilder
              FutureBuilder<FinalModel?>(
                  future: dataModel!,
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      if (snapshot.hasError) {
                        return Center(
                            child: Text(
                                "network error : ${snapshot.error.toString()}"));
                      } else if (snapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: snapshot.data != null &&
                                  snapshot.data!.photos!.isNotEmpty
                              ? GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
//  padding: EdgeInsets.all(11),
                                  itemCount: snapshot.data!.photos!.length!,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 10,
                                          childAspectRatio: 9 / 16),
                                  itemBuilder: (context, index) {
                                    var eachPhoto = snapshot
                                        .data!.photos![index].src!.portrait!;
                                    return InkWell(
                                      onTap: () {
                                        NavigateToDetailPage(snapshot.data!
                                            .photos![index].src!.portrait!);
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(11),
                                        child: Image.network(
                                          eachPhoto,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    );
                                  })
                              : Container(
                                  child: Center(
                                      child: Text(
                                    "data is empty",
                                    style: TextStyle(fontSize: 54),
                                  )),
                                ),
                        );
                      }
                    }
                    return Container();
                  }),
            ],
          ),
        ));
  }

  void NavigateToDetailPage(String url) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WalpaperPage(Wallurl: url);
    }));
  }

  Future<FinalModel?> getWalpaper(
      {String query = "nature", String colorCode = ""}) async {
    // query = controler.text.toString();
    var mApiKey = "ZRjHE8i5lKPmRDg7sMi0RLE8E1dXJxXY2NpoNoyCgyhygj4Q5ZDd6znI";

    var uri = Uri.parse(
        "https://api.pexels.com/v1/search?query=$query&color=$colorCode");
    var response =
        await httpClient.get(uri, headers: {"Authorization": mApiKey});
    if (response.statusCode == 200) {
      var rawData = jsonDecode(response.body);
      var data = FinalModel.fromJason(rawData);
      // dataModel = FinalModel.fromJason(rawData);
      print(response.statusCode);
      return data!;
    } else {
      return null;
    }
  }

  Future<FinalModel?> getTrendingWalpaper() async {
    // query = controler.text.toString();
    var mApiKey = "ZRjHE8i5lKPmRDg7sMi0RLE8E1dXJxXY2NpoNoyCgyhygj4Q5ZDd6znI";

    var uri = Uri.parse("https://api.pexels.com/v1/curated");
    var response =
        await httpClient.get(uri, headers: {"Authorization": mApiKey});
    if (response.statusCode == 200) {
      var rawData = jsonDecode(response.body);
      var data = FinalModel.fromJason(rawData);
      // dataModel = FinalModel.fromJason(rawData);
      print("status code trending ${response.statusCode}");
      print("body treding ${response.body}");
      return data!;
    } else {
      return null;
    }
  }
}

// Expanded(
//                   flex: 17,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: dataModel!=null && dataModel!.photos!.isNotEmpty ? GridView.builder(
//                         //  padding: EdgeInsets.all(11),
//                         itemCount: dataModell!.photos!.length!,
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2,
//                             mainAxisSpacing: 5,
//                             crossAxisSpacing: 5,
//                             childAspectRatio: 9 / 16),
//                         itemBuilder: (context, index) {
//                           var eachPhoto =
//                               dataModell!.photos![index].src!.portrait!;
//                           return ClipRRect(
//                             borderRadius: BorderRadius.circular(11),
//                             child: Image.network(
//                               eachPhoto,
//                               fit: BoxFit.fill,
//                             ),
//                           );
//                         }),
//                   ),
//
//
//             ),
//FutureBuilder
/*FutureBuilder<FinalModel?>(
future: dataModel!,
builder: (_, snapshot) {
if (snapshot.connectionState == ConnectionState.waiting) {
return Center(child: CircularProgressIndicator());
} else {
if (snapshot.hasError) {
return Center(
child: Text(
"network error : ${snapshot.error.toString()}"));
} else if (snapshot.hasData) {
return Padding(
padding: const EdgeInsets.all(8.0),
child: snapshot.data != null &&
snapshot.data!.photos!.isNotEmpty
? GridView.builder(
physics: NeverScrollableScrollPhysics(),
shrinkWrap: true,
//  padding: EdgeInsets.all(11),
itemCount: snapshot.data!.photos!.length!,
gridDelegate:
SliverGridDelegateWithFixedCrossAxisCount(
crossAxisCount: 2,
mainAxisSpacing: 10,
crossAxisSpacing: 10,
childAspectRatio: 9 / 16),
itemBuilder: (context, index) {
var eachPhoto = snapshot
    .data!.photos![index].src!.portrait!;
return InkWell(
onTap: () {
NavigateToDetailPage(snapshot.data!
    .photos![index].src!.portrait!);
},
child: ClipRRect(
borderRadius: BorderRadius.circular(11),
child: Image.network(
eachPhoto,
fit: BoxFit.fill,
),
),
);
})
    : Container(
child: Center(
child: Text(
"data is empty",
style: TextStyle(fontSize: 54),
)),
),
);
}
}
return Container();
}),

 */
//trending walpaper
/*ListView.builder(
scrollDirection: Axis.horizontal,
itemCount: trendingModel!.photos!.length,
itemBuilder: (context, index) {
var eachPhoto =
trendingModel!.photos![index].src!.portrait!;
return Padding(
padding: const EdgeInsets.all(8.0),
child: InkWell(
onTap: () {
NavigateToDetailPage(trendingModel!
    .photos![index].src!.portrait!);
},
child: ClipRRect(
borderRadius: BorderRadius.circular(11),
child: Image.network(
eachPhoto,
fit: BoxFit.fill,
),
),
),
);
})

 */
