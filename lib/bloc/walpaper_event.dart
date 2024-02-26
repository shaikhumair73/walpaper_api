abstract class WalpaperEvent {}

class GetSearchWalpaperEvent extends WalpaperEvent {
  String query;
  GetSearchWalpaperEvent({required this.query});
}

class GetTrendWalpaper extends WalpaperEvent {}
