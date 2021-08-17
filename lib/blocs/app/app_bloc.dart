import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/blocs/bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppState.initial());

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    switch (event) {
      case AppEvent.lightTheme:
        yield state.copyWith(theme: ThemeCubit.lightTheme);
        break;
      case AppEvent.darkTheme:
        yield state.copyWith(theme: ThemeCubit.darkTheme);
        break;
      case AppEvent.autoTheme:
        final theme = state.theme.brightness == Brightness.dark
            ? ThemeCubit.lightTheme
            : ThemeCubit.darkTheme;
        yield state.copyWith(theme: theme);
        break;
    }
  }

  void toggleTheme() {
    final theme =
        state.theme.brightness == Brightness.dark ? ThemeCubit.lightTheme : ThemeCubit.darkTheme;
    emit(state.copyWith(theme: theme));
  }
}
