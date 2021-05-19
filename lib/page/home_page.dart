import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit/page/draw/loading_page.dart';
import 'package:flutter_unit/page/pages.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CupertinoButton(
              child: Text('雷达图示例'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => RadarChartPage()));
              },
            ),
            CupertinoButton(
              child: Text('Flutter 绘制指南'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => DrawBaseKnowledgePage()));
              },
            ),
            CupertinoButton(
              child: Text('Loading'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoadingPage()),
                );
              },
            ),
            CupertinoButton(
              child: Text('Line Chart'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LineChartPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
