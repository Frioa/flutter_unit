import 'package:autoequal/autoequal.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_unit/blocs/bloc.dart';

part 'app_state.g.dart';

@CopyWith()
@Autoequal()
class AppState extends Equatable {
  final ThemeData theme;
  final MarkdownStyleSheetBaseTheme markdownTheme;

  const AppState({
    required this.theme,
    required this.markdownTheme,
  });

  factory AppState.initial() {
    return AppState(
      theme: ThemeCubit.lightTheme,
      markdownTheme: MarkdownStyleSheetBaseTheme.cupertino,
    );
  }

  @override
  List<Object?> get props => _autoequalProps;
}
