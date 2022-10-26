import 'package:date_format/date_format.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:myreceiptapp/pages/line_tiles.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:myreceiptapp/pages/pie.dart';
import 'package:myreceiptapp/service/shared_pref.dart';

class Myspending extends StatefulWidget {
  Myspending({Key? key}) : super(key: key);

  @override
  State<Myspending> createState() => _MyspendingState();
}

class _MyspendingState extends State<Myspending> {
  String? october, nov;

  getthesharedpref() async {
    october = await SharedPreferenceHelper().getUserPhone();
    nov = await SharedPreferenceHelper().getUserAddress();
    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
    await calculate1();
    await calculate2();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    ontheload();
  }

  double given = 0.0, given1 = 0.0;

  calculate1() {
    int talk = int.parse(october!);
    double take = talk <= 10000
        ? 10000.0
        : talk <= 30000
        ? 30000.0
        : 50000.0;
    print(take);
    given = 0 / take;
    print(given);
  }

  calculate2() {
    int talk = int.parse(nov!);
    double take = talk <= 10000
        ? 10000.0
        : talk <= 30000
        ? 30000.0
        : 50000.0;
    given1 = 0 / take;
    print(given1);
  }

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
                padding:
                EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Average Spenditure",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    LineChart(
                      LineChartData(
                        minX: 0,
                        maxX: 12,
                        minY: 0,
                        maxY: 7,
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
                              FlSpot(1, 0),
                              FlSpot(2, 0),
                              FlSpot(3, 0),
                              FlSpot(4, 0),
                              FlSpot(5, 0),
                              FlSpot(6, 0),
                              FlSpot(7, 0),
                              FlSpot(8, 0),
                              FlSpot(9, 0),
                              FlSpot(10, given),
                              FlSpot(11, given1),
                              FlSpot(12, 0),
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
            SizedBox(
              height: 20.0,
            ),
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
