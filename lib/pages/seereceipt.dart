import 'package:flutter/material.dart';

class Seereceipt extends StatefulWidget {
  Seereceipt({Key? key}) : super(key: key);

  @override
  State<Seereceipt> createState() => _SeereceiptState();
}

class _SeereceiptState extends State<Seereceipt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "back",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  width: 30.0,
                ),
                Text(
                  "Caring Pharmacy",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              "RECEIPTS #2627272727",
              style: TextStyle(color: Colors.black45),
            ),
            Divider(
              thickness: 1.0,
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.asset(
                    "images/receipt.png",
                    height: MediaQuery.of(context).size.height / 1.5,
                    fit: BoxFit.fill,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
