import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:myreceiptapp/service/shared_pref.dart';
import 'package:myreceiptapp/vendors/pie_vendor.dart';
import 'package:myreceiptapp/vendors/vendor_tiles.dart';

class Report extends StatefulWidget {
  Report({Key? key}) : super(key: key);

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  String? nov;

  getthesharedpref() async {
    nov = await SharedPreferenceHelper().getUserSpend();
    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();

    await calculate2();
    setState(() {});
  }

  calculate2() {
    double talk = double.parse(nov!);
    double take = talk <= 10000
        ? 10000.0
        : talk <= 30000
        ? 30000.0
        : 50000.0;
    given1 = talk / take;
    print(given1);
  }

  @override
  void initState() {
    super.initState();
    ontheload();
  }

  double given = 0.0, given1 = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "My Spendings",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0),
              ),
              const SizedBox(
                height: 70.0,
              ),
              Material(
                elevation: 5.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Average Income",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      LineChart(
                        LineChartData(
                          minX: 0,
                          maxX: 12,
                          minY: 0,
                          maxY: 7,
                          titlesData: VendorLineTitles.getTitleData(),
                          gridData: FlGridData(
                            show: true,
                            getDrawingHorizontalLine: (value) {
                              return FlLine(
                                color: const Color.fromRGBO(0, 0, 0, 0.12),
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
                                FlSpot(10, 0),
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
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
