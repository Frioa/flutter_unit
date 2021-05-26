import 'package:flutter/material.dart';
import 'package:flutter_unit/draw/draws.dart';

class RadarChartPage extends StatefulWidget {
  @override
  _RadarChartPageState createState() => _RadarChartPageState();
}

class _RadarChartPageState extends State<RadarChartPage> {
  double xScale = 1.0;
  double yScale = 100.0;
  late RadarChart student1;
  late RadarChart student2;

  final unitRadar = RadarChart(values: [1, 1, 1]);

  @override
  void initState() {
    super.initState();
    update();
  }

  void update() {
    student1 = RadarChart(
      values: [xScale, xScale * 2, xScale * 3, xScale * 4, xScale * 5],
      background: Colors.blue.withOpacity(0.2),
    );
    student2 = RadarChart(
      values: [yScale, yScale, yScale, yScale, yScale],
      background: Colors.grey.withOpacity(0.2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('雷达图')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RadarChartWidget(
              size: Size(300, 300),
              radarCharts: [student1, student2],
              descList: ['语文', '数学', '数学', '英语','化学' ],
              descStyle: TextStyle(fontSize: 16, color: Colors.blue),
            ),
            Slider(
              min: 1,
              max: 100,
              value: xScale,
              onChanged: (v) {
                xScale = v;
                update();
                setState(() {});
              },
            ),
            Slider(
              min: 1,
              max: 100,
              value: yScale,
              onChanged: (v) {
                yScale = v;
                update();
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
