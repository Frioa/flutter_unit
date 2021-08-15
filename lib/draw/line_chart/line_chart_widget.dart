import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit/draw/line_chart/line_charts.dart';

class LineChartWidget extends StatefulWidget {
  final double width;
  final double height;
  final EdgeInsets padding;

  const LineChartWidget({
    Key? key,
    this.width = double.infinity,
    this.height = 550.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  }) : super(key: key);

  @override
  _LineChartWidgetState createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  double value = 0;
  bool x = false;
  List<double> values = [2.0, 1.7, 1.4, 1.0, 0.75, 0.5, 0.5];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      padding: widget.padding,
      child: Column(
        children: [
          LineChartAnim(
            values: values,
            width: 288,
            height: 100,
            labels: values.map((e) => '$e').toList(),
            sliderValue: value,
          ),
          Slider(
            value: value,
            max: values.length.toDouble() - 1,
            divisions: values.length - 1,
            onChanged: (i) {
              value = i;
              print('slider $i');
              setState(() {});
            },
          ),
          CupertinoButton(
            child: const Text('初始化'),
            onPressed: () {
              if (x) {
                values = [1.0, 2, 1, 3,1, 3, 6];
              } else {
                values = [.0, .0, .0, .0, 0.0, 0.0, 0.0];
              }
              x = !x;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
