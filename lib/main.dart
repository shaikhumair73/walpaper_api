import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as httpClient;
import 'package:walpaper_api/UI_pages/splash_Page.dart';
import 'package:walpaper_api/UI_pages/wallpaperDetailPage.dart';
import 'package:walpaper_api/datasource/remote/apihelperclass.dart';
import 'package:walpaper_api/datasource/remote/urls.dart';

import 'package:walpaper_api/search_bloc/search_walpaper_bloc.dart';
import 'package:walpaper_api/trend_bloc/walpaper_bloc.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider<WalpaperBloc>(
      create: (context) => WalpaperBloc(apiHelper: ApiHelper()),
    ),
    BlocProvider<SearchWalpaperBloc>(
        create: (context) => SearchWalpaperBloc(helper: ApiHelper())),
  ], child: MyApp()));
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
