import 'package:flutter/material.dart';

class generateReceipt extends StatefulWidget {
  generateReceipt({Key? key}) : super(key: key);

  @override
  State<generateReceipt> createState() => _generateReceiptState();
}

class _generateReceiptState extends State<generateReceipt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Generate Receipt",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0),
            ),
            SizedBox(
              height: 50.0,
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black45, width: 3.0),
                    borderRadius: BorderRadius.circular(20)),
                child: Icon(
                  Icons.add_a_photo,
                  size: 50.0,
                )),
            SizedBox(
              height: 40.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30.0),
              padding: EdgeInsets.symmetric(vertical: 15.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color(0xFF42A232),
                  borderRadius: BorderRadius.circular(12)),
              child: Text(
                "Generate Receipt",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700),
              ),
            )
          ],
        ),
      ),
    );
  }
}
