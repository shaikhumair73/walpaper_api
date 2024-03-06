part of 'search_walpaper_bloc.dart';

abstract class SearchWalpaperEvent {}

class Get_search_wal extends SearchWalpaperEvent {
  String queryy;
  String cololrCode;
  int page;
  Get_search_wal({required this.queryy, this.cololrCode = "",this.page=1});
}
