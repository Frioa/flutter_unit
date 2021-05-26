import 'package:flutter/material.dart';
import 'package:flutter_unit/draw/line_chart/line_chart_widget.dart';

class LineChartPage extends StatefulWidget {
  @override
  _LineChartPageState createState() => _LineChartPageState();
}

class _LineChartPageState extends State<LineChartPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('折线图')),
      body: LineChartWidget(),
    );
  }
}
