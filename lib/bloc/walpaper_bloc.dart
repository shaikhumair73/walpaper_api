import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walpaper_api/bloc/walpaper_bloc.dart';
import 'package:walpaper_api/bloc/walpaper_event.dart';
import 'package:walpaper_api/bloc/walpaper_state.dart';
import 'package:walpaper_api/datasource/remote/apihelperclass.dart';
import 'package:walpaper_api/datasource/remote/app_exception.dart';
import 'package:walpaper_api/datasource/remote/urls.dart';
import 'package:walpaper_api/model.dart';

class WalpaperBloc extends Bloc<WalpaperEvent, WalpaperState> {
  ApiHelper apiHelper;
  WalpaperBloc({required this.apiHelper}) : super(WalpaperInitial()) {
    on<GetSearchWalpaperEvent>((event, emit) async {
      // TODO: implement event handler
      emit(WalpaperLoading());
      try {
        var rawData =
            await apiHelper.getApi("${Url.Search_Url}?query=${event.query}");

        var DataModel = jsonDecode(rawData);
        emit(WalpaperLoaded(mData: DataModel));
      } catch (e) {
        print(e);
      }
    });
    on<GetTrendWalpaper>((event, emit) async {
      // TODO: implement event handler
      emit(WalpaperLoading());
      try {
        var rawData = await apiHelper.getApi("${Url.Curated_Url}");
        var DataModel = FinalModel.fromJason(rawData);
        emit(WalpaperLoaded(mData: DataModel));
      } catch (e) {
        // emit(WalpaperError(error: (e as AppException).toErrorMsg()));
      }
    });
  }
}
