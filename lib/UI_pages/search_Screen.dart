import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walpaper_api/UI_pages/walpaperDetailPage.dart';
import 'package:walpaper_api/bloc/walpaper_state.dart';
import 'package:walpaper_api/model.dart';
import 'package:walpaper_api/search_bloc/search_walpaper_bloc.dart';

class Screen extends StatefulWidget {
  String? search;
  String? colorCode;
  Screen({required this.search, required this.colorCode});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  int pageNo = 1;
  FinalModel? dataModel;
  var searchcontroler = TextEditingController();
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
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("end of grid")));
          BlocProvider.of<SearchWalpaperBloc>(context).add(Get_search_wal(
              queryy: widget.search!, cololrCode: widget.colorCode ?? ""));
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
        title: Text("walpaper"),
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
                        hintText: "search walpaper",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white24),
                        ))),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            BlocBuilder<SearchWalpaperBloc, SearchWalpaperState>(
              builder: (context, state) {
                if (state is SearchWalpaperLoading) {
                  return CircularProgressIndicator();
                } else if (state is SearchWalpaperError) {
                  return Text("error : ${state.error}");
                } else if (state is SearchWalpaperLoaded) {
                  dataModel = state.mdata;
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
                        var img = dataModel!.photos![index];
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
                      });
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
