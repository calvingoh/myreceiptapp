import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:myreceiptapp/service/database.dart';
import 'package:myreceiptapp/service/shared_pref.dart';
import 'package:myreceiptapp/vendors/getbarcode.dart';
import 'package:random_string/random_string.dart';

class generateReceipt extends StatefulWidget {
  generateReceipt({Key? key}) : super(key: key);

  @override
  State<generateReceipt> createState() => _generateReceiptState();
}

class _generateReceiptState extends State<generateReceipt> {
  String Date = "",
      name = "",
      time = "",
      myid = "",
      myname = "",
      myusername = "",
      myimage = "",
      myemail = "",
      myspend = "",
      mysale = "",
      myownspend = "",
      myownsale = "";

  getthesharedpref() async {
    myid = (await SharedPreferenceHelper().getUserId())!;
    myemail = (await SharedPreferenceHelper().getUserEmail())!;
    myimage = (await SharedPreferenceHelper().getUserProfileUrl())!;
    myspend = (await SharedPreferenceHelper().getUserPhone())!;
    mysale = (await SharedPreferenceHelper().getUserAddress())!;
    myusername = (await SharedPreferenceHelper().getDisplayName())!;
    myownspend = (await SharedPreferenceHelper().getUserSpend())!;
    myownsale = (await SharedPreferenceHelper().getUserSale())!;

    setState(() {});
  }

  TextEditingController namecontroller = new TextEditingController();
  TextEditingController pricecontroller = new TextEditingController();
  TextEditingController quantitycontroller = new TextEditingController();
  TextEditingController receiptcontroller = new TextEditingController();
  final _picker = ImagePicker();
  Stream? addStream;
  File? selectedImage;
  bool isSearching = false, _isLoading = false;
  String? addId = randomNumeric(10);
  num total = 0, total1 = 0, total2 = 0;

  loadthedata() async {
    await getthesharedpref();
    print(myownspend);
    addStream = await DatabaseMethods().gettheItems(addId!);
    print(addId);
    setState(() {});
  }

  @override
  void initState() {
    loadthedata();
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
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            ds["Quantity"],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            ds["Item"],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500),
                          ),
                          Spacer(),
                          Text(
                            ds["Price"],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                        ],
                      ),
                      Divider(),
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
      body: SingleChildScrollView(
        child: Container(
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
                height: 30.0,
              ),
              Row(
                children: [
                  Text("RECEIPT #" + addId!),
                  Spacer(),
                  GestureDetector(
                      onTap: () {
                        openAdditem();
                      },
                      child: Text(
                        "Add",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500),
                      ))
                ],
              ),
              Divider(
                color: Colors.black45,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20.0,
                  ),
                  Text("QTY"),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text("ITEM"),
                  Spacer(),
                  Text("RM"),
                  SizedBox(
                    width: 30.0,
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(height: 200, child: allpayment()),
              Divider(
                color: Colors.black45,
              ),
              Row(
                children: [
                  Text(
                    "Total :",
                    style:
                    TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text(
                    total.toString(),
                    style:
                    TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20)),
                child: TextField(
                  controller: receiptcontroller,
                  decoration: InputDecoration(
                      hintText: "Fill Receipt name", border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: () {
                  print(total1);
                  DateTime now = DateTime.now();
                  String formattedDate = DateFormat('h:mma').format(now);
                  final DateFormat formatter = DateFormat('yyyy-MM-dd');
                  final String formatted = formatter.format(now);
                  Map<String, dynamic> addReceipt = {
                    "Id": addId,
                    "Receipt": receiptcontroller.text,
                    "Date": formatted.toString(),
                    "Time": formattedDate.toString()
                  };
                  DatabaseMethods().addReceiptname(addReceipt, addId!);
                  Map<String, dynamic> userInfoMap = {
                    "name": myusername,
                    "username": myemail.replaceAll("@gmail.com", ""),
                    "email": myemail,
                    "Id": myid,
                    "spend": int.parse(myownspend) + total,
                    "sale": int.parse(myownsale) + 1,
                    "Images": myimage,
                  };

                  DatabaseMethods().updateSpend(userInfoMap, myid);
                  var month = DateTime.now();
                  total1 = int.parse(myownspend) + total1;
                  total2 = int.parse(myownsale) + 1;
                  SharedPreferenceHelper().saveUserSpendUrl(total1.toString());
                  SharedPreferenceHelper().saveUserSaleUrl(total2.toString());
                  final formatted1 = formatDate(month, [mm]);
                  num toatlmonth = int.parse(myspend) + total;
                  formatted1 == 10
                      ? SharedPreferenceHelper()
                      .saveUserPhone(toatlmonth.toString())
                      : SharedPreferenceHelper()
                      .saveUserAddress(toatlmonth.toString());
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              getBarcode(name: addId.toString())));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future openAdditem() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Text(
                  "Add Item",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextField(
                    controller: namecontroller,
                    decoration: InputDecoration(
                        hintText: "Fill Item name",
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextField(
                    controller: pricecontroller,
                    decoration: InputDecoration(
                        hintText: "Item Price", border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextField(
                    controller: quantitycontroller,
                    decoration: InputDecoration(
                        hintText: "Item Quantity",
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                GestureDetector(
                  onTap: () {
                    total = 0;
                    Map<String, dynamic> addItem = {
                      "Quantity": quantitycontroller.text,
                      "Item": namecontroller.text,
                      "Price": pricecontroller.text,
                    };
                    DatabaseMethods()
                        .addBarcodeDetail(addItem, addId!)
                        .then((value) => {
                      Navigator.pop(context),
                      namecontroller.text = "",
                      quantitycontroller.text = "",
                      pricecontroller.text = "",
                      setState(() {}),
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.0),
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color(0xFF42A232),
                        borderRadius: BorderRadius.circular(12)),
                    child: Text(
                      "Add",
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
        ),
      ));
}
