import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class PieVendor extends StatefulWidget {
  PieVendor({Key? key}) : super(key: key);

  @override
  State<PieVendor> createState() => _PieVendorState();
}

class _PieVendorState extends State<PieVendor> {
      Map<String, double> dataMap = {
    "Snacks": 5,
    "Icecream": 3,
    "Bread": 2,
    "Drinks": 2,
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
