import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mate/controllers/cubits/internet_cubits/internet_state.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetCubit extends Cubit<InternetState> {
  StreamSubscription? connectivitySubscription;

  InternetCubit() : super(InternetState.Initial) {
    connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        emit(InternetState.Connected);
      } else {
        emit(InternetState.Disconnected);
      }
    });
  }
  @override
  Future<void> close() {
    connectivitySubscription!.cancel();
    return super.close();
  }
}
