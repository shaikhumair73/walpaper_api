import 'package:walpaper_api/model.dart';

abstract class SearchWalpaperState {}

class SearchWalpaperInitial extends SearchWalpaperState {}

class SearchWalpaperLoading extends SearchWalpaperState {}

class SearchWalpaperLoaded extends SearchWalpaperState {
  FinalModel mdata;
  SearchWalpaperLoaded({required this.mdata});
}

class SearchWalpaperError extends SearchWalpaperState {
  final String error;
  SearchWalpaperError({required this.error});
}
