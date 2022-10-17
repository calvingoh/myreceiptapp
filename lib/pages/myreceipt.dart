import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:myreceiptapp/pages/seereceipt.dart';

class MyReceipt extends StatefulWidget {
  MyReceipt({Key? key}) : super(key: key);

  @override
  State<MyReceipt> createState() => _MyReceiptState();
}

class _MyReceiptState extends State<MyReceipt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 45.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "My Receipts",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xFFEFEFF4),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: Icon(
                        Icons.cancel_rounded,
                        color: Color(0xFF8E8E93),
                        size: 20.0,
                      ),
                      hintText: "Search",
                      hintStyle: TextStyle(
                          color: Color.fromRGBO(60, 60, 67, 0.3),
                          fontSize: 18.0)),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                children: [
                  Text(
                    "MY RECEIPTS",
                    style: TextStyle(color: Colors.black45),
                  ),
                  Spacer(),
                  Text("Sort",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500)),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    "Filter",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              Divider(
                thickness: 1.0,
              ),
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Seereceipt()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(
                          "Family Mart",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 18.0),
                        ),
                      ),
                    ),
                      Divider(
                thickness: 1.0,
              ),
                Padding(
                   padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                        "Caring Pharmacy",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 18.0),
                      ),
                ),
                      Divider(
                thickness: 1.0,
              ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                        "IKEA Furniture",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 18.0),
                      ),
                ),
                      Divider(
                thickness: 1.0,
              ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                        "MC Donalds",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 18.0),
                      ),
                ),
                      Divider(
                thickness: 1.0,
              ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                        "KFC",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 18.0),
                      ),
                ),
                      Divider(
                thickness: 1.0,
              ),
               Text("This is the end of your receipts.", style: TextStyle(color: Colors.black45),)
                  ],
                ),
              )
            ],
          )),
    );
  }
}
