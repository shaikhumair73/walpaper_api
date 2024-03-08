import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:walpaper_api/datasource/remote/apihelperclass.dart';
import 'package:walpaper_api/datasource/remote/app_exception.dart';
import 'package:walpaper_api/datasource/remote/urls.dart';
import 'package:walpaper_api/model.dart';
import 'package:walpaper_api/search_bloc/search_walpaper_bloc.dart';
import 'package:walpaper_api/search_bloc/search_walpaper_state.dart';

part 'search_walpaper_event.dart';

class SearchWalpaperBloc
    extends Bloc<SearchWalpaperEvent, SearchWalpaperState> {
  ApiHelper? helper;
  SearchWalpaperBloc({required this.helper}) : super(SearchWalpaperInitial()) {
    on<Get_search_wal>((event, emit) async {
      emit(SearchWalpaperLoading());
      try {
        var rawData = await helper!.getApi(
            "${Url.Search_Url}?query=${event.queryy}&color=${event.cololrCode}&page=${event.page}");

        var DataModel = FinalModel.fromJason(rawData);
        emit(SearchWalpaperLoaded(mdata: DataModel));
      } catch (e) {
        emit(SearchWalpaperError(error: (e as AppException).toErrorMsg()));
      }
    });
  }
}
