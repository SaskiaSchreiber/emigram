import 'package:fl_chart/fl_chart.dart';
import 'package:emigram/emission_data.dart';
import 'package:flutter/material.dart';

const primary = Color(0xFF1EC969);
const accent = Color(0xFFE5FFE7);

class LineChartWidget extends StatelessWidget {
  final List<EmissionData> points;


  const LineChartWidget(this.points, {Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context) {

    return AspectRatio(
      aspectRatio: 2,
      child: LineChart(
        LineChartData(
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            backgroundColor: Colors.black12,
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
