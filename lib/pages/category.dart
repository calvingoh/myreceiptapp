import 'package:flutter/material.dart';
import 'package:myreceiptapp/pages/bottomnav.dart';
import 'package:myreceiptapp/service/shared_pref.dart';

class Category extends StatefulWidget {
  Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
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

      int data=0;
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

   loadthedata() async {

    await getthesharedpref();

   
    setState(() {});
  }

    List<String> category = ['Food', 'Transport', 'Shopping', 'Entertainment'];
  String? categoryItem, show;

  @override
  void initState() {
    loadthedata();
  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
        child: Column(children: [
          Text(
              "Select Category",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0),
            ),
       SizedBox(height: 200.0,),
             Center(
               child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all()),
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                      onChanged: (item) {

                      setState(() {
                            categoryItem = item!;

                          });
  },
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
             ),
             SizedBox(height: 50.0,),
             GestureDetector(
              onTap: (){
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
      ],),),
    );
  }
}