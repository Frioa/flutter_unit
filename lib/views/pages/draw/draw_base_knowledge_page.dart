import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit/draw/basic_knowledge/canvas/canvas.dart';
import 'package:flutter_unit/draw/draws.dart';

class DrawBaseKnowledgePage extends StatefulWidget {
  @override
  _DrawBaseKnowledgePageState createState() => _DrawBaseKnowledgePageState();
}

class _DrawBaseKnowledgePageState extends State<DrawBaseKnowledgePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter 绘制指南')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CupertinoButton(
              child: const Text('Paint 篇'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PaintWidget()));
              },
            ),
            CupertinoButton(
              child: const Text('Canvas 篇'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CanvasWidget()));
              },
            ),
          ],
        ),
      ),
    );
  }
}