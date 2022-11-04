import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:myreceiptapp/pages/seereceipt.dart';
import 'package:myreceiptapp/service/database.dart';
import 'package:myreceiptapp/service/shared_pref.dart';

class MyReceipt extends StatefulWidget {
  MyReceipt({Key? key}) : super(key: key);

  @override
  State<MyReceipt> createState() => _MyReceiptState();
}

class _MyReceiptState extends State<MyReceipt> {
  Stream? receiptStream;
  String id = "";
  bool searching = false;

  getthesharedpref() async {
    id = (await SharedPreferenceHelper().getUserId())!;
    setState(() {});
  }

  getontheload() async {
    await getthesharedpref();
    receiptStream = await DatabaseMethods().gettheReceipt(id);
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }
    setState(() {
      searching = true;
    });
    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    if (queryResultSet.length == 0 && value.length == 1) {
      DatabaseMethods().Search(value, id).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.docs.length; ++i) {
          queryResultSet.add(docs.docs[i].data());
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['Name'].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  Widget allreceipt() {
    return StreamBuilder(
      stream: receiptStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: snapshot.data.docs.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data.docs[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Seereceipt(
                            id: ds["Id"],
                          )));
                },
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  margin: EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Seereceipt(
                                        id: ds["Id"],
                                      )));
                            },
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                ds["Name"],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18.0),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await FirebaseFirestore.instance
                                  .runTransaction(
                                      (Transaction myTransaction) async {
                                    await myTransaction.delete(
                                        snapshot.data.docs[index].reference);
                                  });
                            },
                            child: Icon(
                              Icons.delete,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                      Divider(
                        thickness: 1.0,
                      ),
                    ],
                  ),
                ),
              );
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
                    onChanged: (value) {
                      initiateSearch(value);
                    },
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
                searching
                    ? ListView(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    primary: false,
                    shrinkWrap: true,
                    children: tempSearchStore.map((element) {
                      return buildResultCard(element);
                    }).toList())
                    : Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "MY RECEIPTS",
                          style: TextStyle(color: Colors.black45),
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height / 2,
                        child: allreceipt()),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Widget buildResultCard(data) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Seereceipt(
                  id: data["Id"],
                )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              data["Name"],
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins'),
            ),
            GestureDetector(
              onTap: () async {
                await DatabaseMethods().addDelete(id, data["Id"]);
              },
              child: Icon(
                Icons.delete,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
