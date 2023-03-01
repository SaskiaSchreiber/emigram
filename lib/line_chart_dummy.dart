import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:emigram/mock_data.dart';

const primary = Color(0xFF1EC969);
const accent = Color(0xFFE5FFE7);

class LineChartWidgetDummy extends StatelessWidget {
  final List<MockData> points;

  const LineChartWidgetDummy(this.points, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
  return AspectRatio(
    aspectRatio: 1.5,
    child: LineChart(
      LineChartData(
          backgroundColor: Colors.black12,
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true,reservedSize: 40)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(sideTitles: _bottomTitles),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
        gridData: FlGridData(
          show: true,
          getDrawingHorizontalLine: (value){
            return FlLine(
            color: Colors.black,
            strokeWidth: 0.5,
            );
            },
        getDrawingVerticalLine: (value){
          return FlLine(
          color: Colors.black,
          strokeWidth: 0.5,
          );
          }
        ),
        lineBarsData: [
          LineChartBarData(
            color: primary,
            spots: points.map((point) => FlSpot(point.x, point.y)).toList(),
            isCurved: true,
            belowBarData: BarAreaData(
            show: true,
            color: primary.withOpacity(0.3),
            ),
        dotData: FlDotData(show:false)
        )
        ]),
        swapAnimationDuration: const Duration(milliseconds: 150),
        swapAnimationCurve: Curves.linear,
        ),
        );
        }
        }

  SideTitles get _bottomTitles => SideTitles(
  showTitles: true,
  getTitlesWidget: (value, meta) {
  String text = '';
  switch (value.toInt()) {
    case 0:
    text = 'Jan';
    break;
    case 1:
    text = 'Feb';
    break;
    case 2:
    text = 'Mar';
    break;
    case 3:
    text = 'Apr';
    break;
    case 4:
    text = 'May';
    break;
    case 5:
    text = 'Jun';
    break;
    case 6:
    text = 'Jul';
    break;
    case 7:
    text = 'Aug';
    break;
    case 8:
    text = 'Sep';
    break;
    case 9:
    text = 'Oct';
    break;
    case 10:
    text = 'Nov';
    break;
    case 11:
    text = 'Dez';
    break;
  }

  return Text(text);
  },
  );