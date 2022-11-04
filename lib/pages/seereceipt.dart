import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myreceiptapp/pages/bottomnav.dart';
import 'package:myreceiptapp/service/database.dart';
import 'package:myreceiptapp/service/shared_pref.dart';

class Seereceipt extends StatefulWidget {
  String id;
  Seereceipt({required this.id});

  @override
  State<Seereceipt> createState() => _SeereceiptState();
}

class _SeereceiptState extends State<Seereceipt> {
  String Date = "", name = "", time = "", myid = "", show = "";
  Stream? addStream;
  var total = 0.0;
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

  getthesharedpref() async {
    myid = (await SharedPreferenceHelper().getUserId())!;
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
                  double.parse(ds["Price"]) * double.parse(ds["Quantity"]);

              show = total.toStringAsFixed(2);
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
                            '\$${double.parse(ds["Quantity"]) * double.parse(ds["Price"])}',
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
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios_new_outlined)),
                SizedBox(
                  width: 120.0,
                ),
                Center(
                    child: Text(
                      name,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
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
                  show.toString(),
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}
