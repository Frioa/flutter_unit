import 'package:autoequal/autoequal.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit/blocs/bloc.dart';

part 'app_state.g.dart';

@CopyWith()
@Autoequal()
class AppState extends Equatable {
  final ThemeData theme;

  const AppState({
    required this.theme,
  });

  factory AppState.initial() {
    return AppState(
      theme: ThemeCubit.lightTheme,
    );
  }

  @override
  List<Object?> get props => _autoequalProps;
}
