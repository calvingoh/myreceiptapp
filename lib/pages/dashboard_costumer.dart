import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myreceiptapp/pages/barcode.dart';
import 'package:myreceiptapp/pages/myreceipt.dart';
import 'package:myreceiptapp/service/database.dart';
import 'package:myreceiptapp/service/shared_pref.dart';

class DashboardCostumer extends StatefulWidget {
  DashboardCostumer({Key? key}) : super(key: key);

  @override
  State<DashboardCostumer> createState() => _DashboardCostumerState();
}

class _DashboardCostumerState extends State<DashboardCostumer> {
  String? id, name, image;
  String? spend, show;

  getthissharedpref() async {
    id = (await SharedPreferenceHelper().getUserId())!;
    name = await SharedPreferenceHelper().getDisplayName();
    image = await SharedPreferenceHelper().getUserProfileUrl();
    setState(() {});
  }

  getthisonload() async {
    await getthissharedpref();
    await getThisUserInfo();

    show = double.parse(spend!).toStringAsFixed(2);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getthisonload();
  }

  getThisUserInfo() async {
    QuerySnapshot querySnapshot = await DatabaseMethods().getUserSpend(id!);

    spend = "${querySnapshot.docs[0]["spend"]}";
    print(spend);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: image == null
          ? Center(child: CircularProgressIndicator())
          : Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Hello",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 28.0),
                        ),
                        Image.asset(
                          "images/wave.png",
                          height: 35,
                          width: 35,
                        )
                      ],
                    ),
                    Text(
                      name!,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 20.0),
                    ),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    image!,
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 40.0,
            ),
            Text(
              "Your Insights",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0),
            ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Color(0xFF42A232),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "TODAY'S EXPENDITURE",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  spend == null
                      ? Center(child: CircularProgressIndicator())
                      : Text(
                    show.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(34, 213, 102, 0.54),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Text(
                "1",
                style:
                TextStyle(color: Color.fromRGBO(34, 213, 102, 0.54)),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              "Your Insights",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BarcodeScan()));
                    },
                    child: Image.asset(
                      "images/scannew.png",
                      height: 160,
                      width: 160,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyReceipt()));
                    },
                    child: Image.asset(
                      "images/past.png",
                      height: 160,
                      width: 160,
                    ),
                  )
                ])
          ],
        ),
      ),
    );
  }
}

