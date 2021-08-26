import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/blocs/bloc.dart';
import 'package:flutter_unit/utils/utils.dart';
import 'package:flutter_unit/views/views.dart';

class DesignPage extends StatefulWidget {
  @override
  _DesignPageState createState() => _DesignPageState();
}

class _DesignPageState extends State<DesignPage> {
  String? text;

  @override
  void initState() {
    super.initState();
    onPostFrame(() async {
      text = await rootBundle.loadString('design/design_ptterns_dart.md');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WrapMarkdownWidget(text: text),
    );
  }
}
