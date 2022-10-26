import 'package:flutter/material.dart';
import 'package:myreceiptapp/pages/login.dart';
import 'package:myreceiptapp/service/shared_pref.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String myname = "", myusername = "", myimage = "", myemail = "";

  getthesharedpref() async {
    myemail = (await SharedPreferenceHelper().getUserEmail())!;
    myname = (await SharedPreferenceHelper().getDisplayName())!;
    myemail = (await SharedPreferenceHelper().getUserEmail())!;
    myimage = (await SharedPreferenceHelper().getUserProfileUrl())!;
    setState(() {});
  }

  loadthedata() async {
    await getthesharedpref();
    setState(() {});
  }

  @override
  void initState() {
    loadthedata();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Profile",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0),
              ),
              SizedBox(
                height: 30.0,
              ),
              Center(
                  child: Material(
                    elevation: 8.0,
                    borderRadius: BorderRadius.circular(80),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(80),
                      child: Image.network(
                        myimage,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )),
              SizedBox(
                height: 70.0,
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.person_outline,
                      size: 35.0,
                      color: Color(0xFF42A132),
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          myname,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.email_outlined,
                      size: 35.0,
                      color: Color(0xFF42A132),
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          myemail,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 19.0,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 80.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => logIn()));
                },
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    decoration: BoxDecoration(
                        color: Color(0xFF42A132),
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                        child: Text(
                          "LogOut",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0),
                        )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
