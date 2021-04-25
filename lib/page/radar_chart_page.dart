import 'package:flutter/material.dart';
import 'package:flutter_unit/custom_draw/custom_draw.dart';

class RadarChartPage extends StatefulWidget {
  @override
  _RadarChartPageState createState() => _RadarChartPageState();
}

class _RadarChartPageState extends State<RadarChartPage> {
  double xScale = 1.0;
  double yScale = 100.0;
  late RadarChart x;
  late RadarChart y;

  final unitRadar = RadarChart(values: [1, 1, 1]);

  @override
  void initState() {
    super.initState();
    update();
  }

  void update() {
    x = RadarChart(
      values: [xScale, xScale * 2, xScale * 3, xScale * 4, xScale * 5, xScale * 6],
      background: Colors.blue.withOpacity(0.2),
    );
    y = RadarChart(
      values: [yScale, yScale, yScale, yScale, yScale, yScale],
      background: Colors.grey.withOpacity(0.2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RadarChartWidget(
              size: Size(300, 300),
              radarCharts: [x, y],
              layerCount: 5,
              descList: ['语文', '数学', '数学', '英语', '物理', '生物'],
              descStyle: TextStyle(fontSize: 16, color: Colors.blue),
            ),
            Slider(
              min: 1,
              max: 100,
              value: xScale,
              onChanged: (v) {
                xScale = v;
                update();
                setState(() {
                  print(x);
                });
              },
            ),
            Slider(
              min: 1,
              max: 100,
              value: yScale,
              onChanged: (v) {
                yScale = v;
                update();
                setState(() {
                  print(y);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
