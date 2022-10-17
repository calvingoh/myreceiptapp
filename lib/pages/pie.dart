import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class Pie extends StatefulWidget {
  Pie({Key? key}) : super(key: key);

  @override
  State<Pie> createState() => _PieState();
}

class _PieState extends State<Pie> {
  Map<String, double> dataMap = {
    "Food": 5,
    "Transport": 3,
    "Shopping": 2,
    "Entertainment": 2,
  };
  final colorList = <Color>[
    Color.fromARGB(255, 12, 108, 187),
    Color.fromARGB(255, 62, 169, 65),
    Colors.orange,
    Colors.red
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        child: Center(
          child: PieChart(
            dataMap: dataMap,
            colorList: colorList,
            chartRadius: MediaQuery.of(context).size.width / 1,
            legendOptions: LegendOptions(
              showLegendsInRow: true,
              legendPosition: LegendPosition.bottom,
            ),
            chartValuesOptions: ChartValuesOptions(
              showChartValuesInPercentage: true,
            ),
          ),
        ),
      ),
    );
  }
}