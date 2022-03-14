import 'package:bloc_fluttery/logic/cubit/settings_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit()
      : super(
          const SettingsState(
            appNotifications: false,
            emailNotifications: false,
          ),
        );

  void toggleAppNotifications({required bool newValue}) {
    emit(state.copyWith(appNotifications: newValue));
  }

  void toggleEmailNotifications({required bool newValue}) =>
      emit(state.copyWith(emailNotifications: newValue));
}
