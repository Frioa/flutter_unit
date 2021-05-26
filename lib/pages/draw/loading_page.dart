import 'package:flutter/material.dart';
import 'package:flutter_unit/draw/draws.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Loading')),
      body: CircleLoadingWidget(),
    );
  }
}
