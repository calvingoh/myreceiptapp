import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myreceiptapp/service/database.dart';
import 'package:myreceiptapp/service/shared_pref.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String spend = "", sale = "", id = "";

  getthissharedpref() async {
    id = (await SharedPreferenceHelper().getUserId())!;

    setState(() {});
  }

  getThisUserInfo() async {
    QuerySnapshot querySnapshot = await DatabaseMethods().getUserSpend(id);

    spend = "${querySnapshot.docs[0]["spend"]}";
    sale = "${querySnapshot.docs[0]["sale"]}";
    print(spend);
    setState(() {});
  }

  getthisonload() async {
    await getthissharedpref();
    await getThisUserInfo();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getthisonload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 45.0, horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Dashboard",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0),
            ),
            SizedBox(
              height: 90.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 30.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(0xFF42A132),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Text(
                        "Total Sales",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      sale == null
                          ? Center(
                          child: CircularProgressIndicator(
                              color: Colors.white))
                          : Text(
                        sale,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 30.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(0xFF42A132),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Text(
                        "Total Income",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      spend == null
                          ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ))
                          : Text(
                        spend,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
