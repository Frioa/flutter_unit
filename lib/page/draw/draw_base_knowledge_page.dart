import 'package:flutter/material.dart';
import 'package:flutter_unit/draw/draws.dart';

class DrawBaseKnowledgePage extends StatefulWidget {
  @override
  _DrawBaseKnowledgePageState createState() => _DrawBaseKnowledgePageState();
}

class _DrawBaseKnowledgePageState extends State<DrawBaseKnowledgePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Loading')),
      body: CircleLoadingWidget(),
    );
  }
}