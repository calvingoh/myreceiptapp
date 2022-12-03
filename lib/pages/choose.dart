import 'package:flutter/material.dart';
import 'package:myreceiptapp/pages/bottomnav.dart';
import 'package:myreceiptapp/service/database.dart';
import 'package:myreceiptapp/service/shared_pref.dart';
import 'package:myreceiptapp/vendors/vendornav.dart';

class Choose extends StatefulWidget {
  String id;
  Choose({required this.id});

  @override
  State<Choose> createState() => _ChooseState();
}

class _ChooseState extends State<Choose> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF80dcf1),
      body: Container(
        margin: EdgeInsets.only(top: 40.0),
        child: Column(
          children: [
            Image.asset("images/qrcode.jpeg"),
            SizedBox(
              height: 40.0,
            ),
            Text(
              "What type of user are you?",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 50.0,
            ),
            GestureDetector(
              onTap: () async {
                await SharedPreferenceHelper().saveUserRole("Costumer");
                DatabaseMethods().updateRole(widget.id, "Costumer");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Bottombar()));
              },
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  padding:
                  EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0),
                  decoration: BoxDecoration(
                      color: Color(0xFF1ba4dc),
                      borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    "Costumer",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            GestureDetector(
              onTap: () async {
                await SharedPreferenceHelper().saveUserRole("Vendor");
                DatabaseMethods().updateRole(widget.id, "Vendor");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => VendorNav()));
              },
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  padding:
                  EdgeInsets.symmetric(vertical: 15.0, horizontal: 60.0),
                  decoration: BoxDecoration(
                      color: Color(0xFF1ba4dc),
                      borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    "Vendor",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold),
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
