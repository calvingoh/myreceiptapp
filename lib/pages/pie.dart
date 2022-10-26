import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:myreceiptapp/service/shared_pref.dart';

class Pie extends StatefulWidget {
  Pie({Key? key}) : super(key: key);

  @override
  State<Pie> createState() => _PieState();
}

class _PieState extends State<Pie> {
  String myfood = "", mytansport = "", myshopping = "", myentertainment = "";
  double? food, trans, enter, shop;

  getthesharedpref() async {
    mytansport = (await SharedPreferenceHelper().getUserTransport())!;
    myentertainment = (await SharedPreferenceHelper().getUserEntertainment())!;
    myshopping = (await SharedPreferenceHelper().getUserShopping())!;
    setState(() {});
  }

  loadthedata() async {
    await getthesharedpref();
    food = await double.parse(myfood);
    trans = await double.parse(mytansport);
    shop = await double.parse(myshopping);
    enter = await double.parse(myentertainment);
    setState(() {});
  }

  @override
  void initState() {
    loadthedata();

    super.initState();
  }

  final colorList = <Color>[
    Color.fromARGB(255, 12, 108, 187),
    Color.fromARGB(255, 62, 169, 65),
    Colors.orange,
    Colors.red
  ];
  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {
      "Food": food==null? 1: food!,
      "Transport":trans==null ? 1:trans!,
      "Shopping":shop==null?1: shop!,
      "Entertainment":enter==null?1: enter!,
    };
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
