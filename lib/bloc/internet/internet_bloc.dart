import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:weather/consetance/enums.dart';

part 'internet_event.dart';
part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  final Connectivity connectivity;
  StreamSubscription connectivityStreamSubscription;

  InternetBloc({this.connectivity}) : super(InternetLoading()) {
    print("xxr");
    connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.wifi) {
        print("xxrppp $connectivityResult");
        // InternetBloc(connectivity: connectivity)
        //   ..add(InternetWifiOrMobile(internetType: InternetType.Wifi));
        emitInternetConnected(InternetType.Wifi);
        // InternetWifiOrMobile(internetType: InternetType.Wifi);
      } else if (connectivityResult == ConnectivityResult.mobile) {
        // mapEventToState(
        //     InternetWifiOrMobile(internetType: InternetType.Mobile));

        emitInternetConnected(InternetType.Mobile);
        //InternetWifiOrMobile(internetType: InternetType.Mobile);
      } else if (connectivityResult == ConnectivityResult.none) {
        //mapEventToState(NoInternet());
        emitInternetDisconnected();
        //NoInternet();
      }
    });
  }

  void emitInternetConnected(InternetType _connectionType) =>
      emit(InternetWifiOrMobileState(internetType: _connectionType));

  void emitInternetDisconnected() => emit(NoInternetState());

  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }

  @override
  Stream<InternetState> mapEventToState(
    InternetEvent event,
  ) async* {
    // TODO: implement mapEventToState
    print("xxrpppevent $event");
    if (event is InternetWifiOrMobile) {
      yield InternetWifiOrMobileState(internetType: InternetType.Wifi);
    } else if (event is NoInternet) {
      yield NoInternetState();
    } else {
      yield InternetLoading();
    }
  }
}
