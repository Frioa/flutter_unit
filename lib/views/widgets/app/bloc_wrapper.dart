import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/blocs/bloc.dart';

class BlocWrapper extends StatefulWidget {
  final Widget child;

  const BlocWrapper(this.child);

  @override
  _BlocWrapperState createState() => _BlocWrapperState();
}

class _BlocWrapperState extends State<BlocWrapper> {
  @override
  void initState() {
    super.initState();
    Bloc.observer = SimpleBlocObserver();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      //使用MultiBlocProvider包裹
      providers: [
        //Bloc提供器
        BlocProvider<AppBloc>(create: (_) => AppBloc()..add(AppEvent.lightTheme)),
      ],
      child: widget.child,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
