import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:myreceiptapp/pages/line_tiles.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:myreceiptapp/pages/pie.dart';

class Myspending extends StatefulWidget {
  Myspending({Key? key}) : super(key: key);

  @override
  State<Myspending> createState() => _MyspendingState();
}

class _MyspendingState extends State<Myspending> {
   Map<String, double> dataMap = {
    "Flutter": 5,
    "React": 3,
    "Xamarin": 2,
    "Ionic": 2,
  };

   final colorList = <Color>[
    Color.fromARGB(255, 12, 108, 187),
    Color.fromARGB(255, 62, 169, 65),
    Colors.orange,
    Colors.red
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "My Spendings",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Material(
                  elevation: 5.0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Average Spenditure",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 20.0,),
                        LineChart(
                          LineChartData(
                            minX: 0,
                            maxX: 11,
                            minY: 0,
                            maxY: 6,
                            titlesData: LineTitles.getTitleData(),
                            gridData: FlGridData(
                              show: true,
                              getDrawingHorizontalLine: (value) {
                                return FlLine(
                                  color: Color.fromRGBO(0, 0, 0, 0.12),
                                  strokeWidth: 2,
                                );
                              },
                            ),
                            borderData: FlBorderData(
                              show: true,
                              border: Border.all(
                                  color: const Color(0xff37434d), width: 1),
                            ),
                            lineBarsData: [
                              LineChartBarData(
                                spots: [
                                  FlSpot(0, 3),
                                  FlSpot(2.6, 2),
                                  FlSpot(4.9, 5),
                                  FlSpot(6.8, 2.5),
                                  FlSpot(8, 4),
                                 
                                  
                                  FlSpot(9.5, 3),
                                  FlSpot(10, 3),
                                   FlSpot(10.5, 3),
                                  FlSpot(11, 4),
                                ],
                                isCurved: true,
        
                                barWidth: 2,
                                dotData: FlDotData(show: false),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          SizedBox(height: 20.0,),
               Material(
                elevation: 5.0,
                 child: Container(
                  padding: EdgeInsets.only(top: 10.0, left: 10.0),
                   child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                        Text(
                          "Categories",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w400),
                        ),
                       Container(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        child: Pie()),
                     ],
                   ),
                 ),
               ),
              ],
            ),
          ),
        ),
      );
}
