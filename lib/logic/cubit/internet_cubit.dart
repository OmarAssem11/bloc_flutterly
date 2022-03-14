import 'dart:async';
import 'package:bloc_fluttery/constants/enums.dart';
import 'package:bloc_fluttery/logic/cubit/internet_state.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  late StreamSubscription connectivityStreamSubscription;
  InternetCubit({required this.connectivity}) : super(InternetLoadingState()) {
    connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.wifi) {
        emit(InternetConnectedState(connectionType: ConnectionType.wifi));
      } else if (connectivityResult == ConnectivityResult.mobile) {
        emit(InternetConnectedState(connectionType: ConnectionType.mobile));
      } else if (connectivityResult == ConnectivityResult.none) {
        emit(InternetDisconnectedState());
      }
    });
  }

  void emitInternetConnected(ConnectionType connectionType) =>
      emit(InternetConnectedState(connectionType: connectionType));
  void emitInternetDisconnected() => emit(InternetDisconnectedState());

  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }
}
