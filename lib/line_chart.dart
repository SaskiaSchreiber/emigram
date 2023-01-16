import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:emigram/emission_data.dart';
import 'package:flutter/material.dart';

const primary = Color(0xFF1EC969);
const accent = Color(0xFFE5FFE7);

Future<List<FlSpot>> _getData() async {
  User? newUser = FirebaseAuth.instance.currentUser;
  final emission = FirebaseDatabase.instance.ref();
  final userRef = emission.child("Emission/${newUser?.uid}");
  final snap = await userRef.get();
  final emi = <double>[];
  //final f_daten ={} as Map<dynamic, dynamic>;
  List<FlSpot> spots=[];
  if(snap.exists){
    final daten = snap.value as Map<dynamic,dynamic>;
    print(daten.runtimeType);
    // Daten für Chart oder Grafiken formatieren
    for(var dat in daten.keys){
      var mobMap = daten[dat] as Map<dynamic, dynamic>;
      double sum=0;
      for(var mob in mobMap.keys){
        //print(d[elt]);
        sum= sum + mobMap[mob];
      }

      //spots.add(FlSpot(dat, sum));
      emi.add(sum);
    }
    /*Daten als spots vorbereiten */
    emi.asMap().forEach((index, value) {
      spots.add(FlSpot(index.toDouble(), value));
    });
   print(spots);
  }
  return spots;
}

class LineChartWidget extends StatelessWidget {
  final List<EmissionData> points;



  const LineChartWidget(this.points, {Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context) {


    return FutureBuilder<List<FlSpot>>(
        future: _getData(),
        builder:(context, snapshot){
          if(snapshot.hasData){
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
                          spots: snapshot.data,
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
          }else if(snapshot.hasError){
            return Text("Error: ${snapshot.error}");
          }
          return const CircularProgressIndicator();
        },
        );
  }
}
