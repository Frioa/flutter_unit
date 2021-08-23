import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_unit/blocs/bloc.dart';
import 'package:flutter_unit/utils/logs/logs.dart';
import 'package:flutter_unit/views/views.dart';

void main() => runApp(BlocWrapper(MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (_, state) {
        return ScreenUtilInit(
          builder: () {
            return MaterialApp(
              theme: state.theme,
              home: const MyHomePage(title: 'Flutter Demo Home Page'),
            );
          },
        );
      },
    );
  }
}
