import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:myreceiptapp/service/database.dart';
import 'package:myreceiptapp/vendors/vendornav.dart';

class getBarcode extends StatefulWidget {
  String name;
  getBarcode({ required this.name});
  

  @override
  State<getBarcode> createState() => _getBarcodeState();
}

class _getBarcodeState extends State<getBarcode> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("#"+ widget.name, style: TextStyle(color: Colors.black, fontSize: 28.0, fontWeight: FontWeight.bold),),
            SizedBox(height: 80.0,),
            Center(
              child: Card(
                color: Colors.white,
                elevation: 6,
                shadowColor: Colors.amber,
                child: Padding(padding: EdgeInsets.all(16),
               child: BarcodeWidget(
                barcode: Barcode.code128(),
                data: widget.name,
                width: 200,
                height: 200,
                drawText: false,
               ) ),
              ),
            ),
            SizedBox(height: 70.0,),
             GestureDetector(
              onTap: () async {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> VendorNav()));
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                padding: EdgeInsets.symmetric(vertical: 15.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color(0xFF42A232),
                    borderRadius: BorderRadius.circular(12)),
                child: Text(
                  "Proceed",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
