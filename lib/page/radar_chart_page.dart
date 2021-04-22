import 'package:flutter/material.dart';
import 'package:flutter_unit/custom_draw/custom_draw.dart';

class RadarChartPage extends StatefulWidget {
  @override
  _RadarChartPageState createState() => _RadarChartPageState();
}

class _RadarChartPageState extends State<RadarChartPage> {
  RadarChart x = RadarChart(values: [
    50,
    50,
    50,
    50,
    50,
  ], background: Colors.blue.withOpacity(0.2));
  RadarChart y = RadarChart(values: [
    100,
    100,
    100,
    100,
    100,
  ], background: Colors.grey.withOpacity(0.2));
  RadarChart z = RadarChart(values: [
    25,
    25,
    25,
    25,
    25,
  ], background: Colors.amber.withOpacity(0.2));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RadarChartWidget(
            size: Size(300, 300),
            radarCharts: [x, y, z],
            layerCount: 5,
            // baseCoordinateColor: Colors.blue.withOpacity(0.2),
          ),
        ],
      ),
    );
  }
}
