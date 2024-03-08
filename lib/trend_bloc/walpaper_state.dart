import 'package:walpaper_api/model.dart';

abstract class WalpaperState {}

class WalpaperInitial extends WalpaperState {}

class WalpaperLoading extends WalpaperState {}

class WalpaperLoaded extends WalpaperState {
  FinalModel mData;
  WalpaperLoaded({required this.mData});
}

class WalpaperError extends WalpaperState {
  String error;
  WalpaperError({required this.error});
}
