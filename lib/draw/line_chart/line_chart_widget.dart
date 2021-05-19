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
  static const double sliderHeight = 258.0;

  double value = 0.0;

  double index = 0;
  List<double> values = [2.0, 1.7, 1.4, 1.0, 0.75, 0.5, 0.5];

  @override
  void initState() {
    super.initState();
    value = 0.0;
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
          ),
          Slider(
            value: index,
            min: .0,
            max: values.length.toDouble(),
            divisions: values.length - 1,
            onChanged: (i) {
              index = i;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
