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
