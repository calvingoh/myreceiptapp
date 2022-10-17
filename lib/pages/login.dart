import 'package:flutter/material.dart';
import 'package:myreceiptapp/pages/choose.dart';

class logIn extends StatefulWidget {
  logIn({Key? key}) : super(key: key);

  @override
  State<logIn> createState() => _logInState();
}

class _logInState extends State<logIn> {
  bool name = false, show = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Image.asset(
                  "images/myreceipt.png",
                  width: MediaQuery.of(context).size.width / 1.5,
                  fit: BoxFit.cover,
                ),
              ),
              name
                  ? SizedBox(
                height: 60.0,
              )
                  : SizedBox(
                height: 70.0,
              ),
              name
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Enter Your Name",
                    ),
                  ),
                ],
              )
                  : Container(),
              SizedBox(
                height: 40.0,
              ),
              Text(
                "Email Address",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter Email Address",
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Text(
                "Password",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400),
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: "Enter Password",
                    suffixIcon: show
                        ? GestureDetector(
                      onTap: () {
                        show = false;
                        setState(() {});
                      },
                      child: Icon(
                        Icons.remove_red_eye,
                        color: Colors.black,
                      ),
                    )
                        : GestureDetector(
                      onTap: () {
                        show = true;
                        setState(() {});
                      },
                      child: Icon(
                        Icons.password_outlined,
                        color: Colors.black,
                      ),
                    )),
                obscureText: show ? true : false,
              ),
              SizedBox(
                height: 50.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Choose()));
                },
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    decoration: BoxDecoration(
                        color: Color(0xFF60b876),
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                            fontWeight: FontWeight.w400),
                      ),
                    )),
              ),
              name
                  ? SizedBox(
                height: 0.0,
              )
                  : SizedBox(
                height: 30.0,
              ),
              name
                  ? Container()
                  : Center(
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              name
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already a User?",
                    style: TextStyle(fontSize: 16.0),
                  ),
                  GestureDetector(
                    onTap: () {
                      name = false;
                      setState(() {});
                    },
                    child: Text(
                      " LogIn",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF42A232)),
                    ),
                  ),
                ],
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "New User?",
                    style: TextStyle(fontSize: 16.0),
                  ),
                  GestureDetector(
                    onTap: () {
                      name = true;
                      setState(() {});
                    },
                    child: Text(
                      " Create Account",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF42A232)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
