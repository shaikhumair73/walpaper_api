import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:walpaper_api/UI_pages/wallpaperDetailPage.dart';
import 'package:walpaper_api/colorModel.dart';
import 'package:walpaper_api/model.dart';
import 'package:walpaper_api/search_bloc/search_walpaper_bloc.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:walpaper_api/search_bloc/search_walpaper_state.dart';

class Screen extends StatefulWidget {
  String? search;
  String? colorCode;
  Screen({required this.search, required this.colorCode});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  List<String> blurHashes = [
    'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
    'LKO2?U%2Tw=w]~RBVZRi};RPxuwH',
    'LKO2?U%2Tw=w]~RBVZRi};RPxuwH',
    // Add more BlurHash strings as needed
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

  List<Photos> listPhotos = [];
  int pageNo = 1;
  FinalModel? dataModel;

  var searchcontroler = TextEditingController();
  var controler = TextEditingController();
  ScrollController? scrollController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        print(scrollController!.position.pixels);
        if (scrollController!.position.pixels ==
            scrollController!.position.maxScrollExtent) {
          print("end of grid");
          Align(
              alignment: Alignment.bottomCenter,
              child: CircularProgressIndicator());
          pageNo++;
          //hit api with updated page index
          BlocProvider.of<SearchWalpaperBloc>(context).add(Get_search_wal(
              queryy: widget.search!,
              cololrCode: widget.colorCode ?? "",
              page: pageNo));
        }
      });
    BlocProvider.of<SearchWalpaperBloc>(context).add(Get_search_wal(
        queryy: widget.search!, cololrCode: widget.colorCode ?? ""));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("wallpaper"),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
                child: TextField(
                    controller: searchcontroler,
                    decoration: InputDecoration(
                        suffix: TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return Screen(
                                  search: searchcontroler.text.isNotEmpty
                                      ? searchcontroler.text.toString()
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
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            BlocListener<SearchWalpaperBloc, SearchWalpaperState>(
              listener: (context, state) {
                if (state is SearchWalpaperLoading) {
                  CircularProgressIndicator();
                } else if (state is SearchWalpaperLoaded) {
                  dataModel = state.mdata;
                  listPhotos.addAll(dataModel!.photos!);
                  setState(() {});
                }
              },
              child: listPhotos.isNotEmpty
                  ? GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          childAspectRatio: 9 / 16),
                      itemCount: listPhotos.length,
                      itemBuilder: (context, index) {
                        var img = listPhotos[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (contetx) {
                                  return WalpaperPage(
                                      Wallurl: img!.src!.portrait!);
                                }));
                              },
                              child: Container(
                                  child: Image.network(
                                "${img.src!.portrait}",
                                fit: BoxFit.fill,
                              )),
                            ),
                          ),
                        );
                      })
                  : SizedBox(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
