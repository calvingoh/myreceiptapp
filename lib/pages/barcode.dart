import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:myreceiptapp/pages/bottomnav.dart';
import 'package:myreceiptapp/service/database.dart';
import 'package:myreceiptapp/service/shared_pref.dart';
import 'package:myreceiptapp/vendors/vendornav.dart';

class BarcodeScan extends StatefulWidget {
  BarcodeScan({Key? key}) : super(key: key);

  @override
  State<BarcodeScan> createState() => _BarcodeScanState();
}

class _BarcodeScanState extends State<BarcodeScan> {
  String? scanresult;

  @override
  void initState() {
    scanBarcode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Column(
          children: [
            Text(
              "Scan QR Receipt",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0),
            ),
            scanresult == null
                ? Container()
                : Expanded(child: getdata(id: scanresult.toString()))
          ],
        ),
      ),
    );
  }

  Future scanBarcode() async {
    String scanResult;
    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
    } on PlatformException {
      scanResult = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      this.scanresult = scanResult;
      print(scanResult);
    });
  }
}

class getdata extends StatefulWidget {
  String id;
  getdata({required this.id});

  @override
  State<getdata> createState() => _getdataState();
}

class _getdataState extends State<getdata> {
  String Date = "",
      name = "",
      time = "",
      myid = "",
      myname = "",
      myusername = "",
      myimage = "",
      myemail = "",
      myspend = "",
      myfood = "",
      mytansport = "",
      myshopping = "",
      myentertainment = "";
  Stream? addStream;
  num total = 0;
  int data = 0;
  int _counter = 0;

  late Timer _timer;
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  List<String> category = ['Food', 'Transport', 'Shopping', 'Entertainment'];
  String? categoryItem;

  getthesharedpref() async {
    myid = (await SharedPreferenceHelper().getUserId())!;
    myemail = (await SharedPreferenceHelper().getUserEmail())!;
    myname = (await SharedPreferenceHelper().getDisplayName())!;
    myimage = (await SharedPreferenceHelper().getUserProfileUrl())!;
    myspend = (await SharedPreferenceHelper().getUserSpend())!;
    myfood = (await SharedPreferenceHelper().getUserFood())!;
    mytansport = (await SharedPreferenceHelper().getUserTransport())!;
    myentertainment = (await SharedPreferenceHelper().getUserEntertainment())!;
    myshopping = (await SharedPreferenceHelper().getUserShopping())!;
    setState(() {});
  }

  getThisUserInfo() async {
    QuerySnapshot querySnapshot =
    await DatabaseMethods().getUserInfo(widget.id);

    name = "${querySnapshot.docs[0]["Receipt"]}";
    Date = "${querySnapshot.docs[0]["Date"]}";
    time = "${querySnapshot.docs[0]["Time"]}";
    setState(() {});
  }

  loadthedata() async {
    await getThisUserInfo();
    await getthesharedpref();
    addStream = await DatabaseMethods().gettheItems(widget.id);
    setState(() {});
  }

  @override
  void initState() {
    loadthedata();
    _startTimer();
    super.initState();
  }

  Widget allpayment() {
    return StreamBuilder(
      stream: addStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: snapshot.data.docs.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data.docs[index];
              total = total +
                  int.parse(ds["Price"]) * int.parse(ds["Quantity"]);
              return Container(
                  margin: EdgeInsets.only(right: 10.0, bottom: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ds["Item"],
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "(" + ds["Quantity"] + "x" + ds["Price"] + ")",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '${int.parse(ds["Quantity"]) * int.parse(ds["Price"])}',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      )
                    ],
                  ));
            })
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.0,
            ),
            Center(
                child: Text(
                  name,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold),
                )),
            SizedBox(
              height: 30.0,
            ),
            Text(
              "Date : " + Date,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Time : " + time,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30.0,
            ),
            Expanded(child: allpayment()),
            Divider(
              color: Colors.black45,
            ),
            Row(
              children: [
                Text(
                  "Total :",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(
                  total.toString(),
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all()),
              padding: EdgeInsets.only(right: 20.0, left: 20.0),
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                    onChanged: (item) => setState(() {
                      categoryItem = item!;
                    }),
                    hint: Text(
                      "Category",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 20.0),
                    ),
                    value: categoryItem,
                    items: category
                        .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(fontSize: 22),
                        )))
                        .toList()),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () {
                if (categoryItem != null) {
                  Map<String, dynamic> addreceipt = {
                    "Id": widget.id,
                    "Name": name,
                    "Key": name.substring(0, 1).toUpperCase(),
                  };

                  DatabaseMethods()
                      .addUserReceipt(addreceipt, myid)
                      .then((value) {
                    Map<String, dynamic> userInfoMap = {
                      "name": myusername,
                      "username": myemail.replaceAll("@gmail.com", ""),
                      "email": myemail,
                      "Id": myid,
                      "spend": int.parse(myspend) + total,
                      "sale": 0,
                      "Images": myimage,
                    };
                    DatabaseMethods().updateSpend(userInfoMap, myid);
                    var month = DateTime.now();

                    final formatted = formatDate(month, [mm]);
                    num toatlmonth = int.parse(myspend) + total;
                    SharedPreferenceHelper()
                        .saveUserSpendUrl(toatlmonth.toString());
                    formatted == 10
                        ? SharedPreferenceHelper()
                        .saveUserPhone(toatlmonth.toString())
                        : SharedPreferenceHelper()
                        .saveUserAddress(toatlmonth.toString());
                    categoryItem == "Food"
                        ? data = int.parse(myfood) + 1
                        : categoryItem == "Transport"
                        ? data = int.parse(mytansport) + 1
                        : categoryItem == "Shopping"
                        ? data = int.parse(myshopping) + 1
                        : data = int.parse(myentertainment) + 1;
                    categoryItem == "Food"
                        ? SharedPreferenceHelper().saveUserFood(data.toString())
                        : categoryItem == "Transport"
                        ? SharedPreferenceHelper()
                        .saveUserTransport(data.toString())
                        : categoryItem == "Shopping"
                        ? SharedPreferenceHelper()
                        .saveUserShopping(data.toString())
                        : SharedPreferenceHelper()
                        .saveUserEntertainment(data.toString());

                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Bottombar()));
                  });
                }
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                padding: EdgeInsets.symmetric(vertical: 15.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color(0xFF42A232),
                    borderRadius: BorderRadius.circular(12)),
                child: Text(
                  "Done",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
