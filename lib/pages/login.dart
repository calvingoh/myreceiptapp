import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myreceiptapp/main.dart';
import 'package:myreceiptapp/pages/choose.dart';
import 'package:myreceiptapp/service/database.dart';
import 'package:myreceiptapp/service/shared_pref.dart';
import 'package:random_string/random_string.dart';

class logIn extends StatefulWidget {
  logIn({Key? key}) : super(key: key);

  @override
  State<logIn> createState() => _logInState();
}

class _logInState extends State<logIn> {
  bool name = false, show = true;
  String spend = "",
      myname = "",
      myemail = "",
      myusername = "",
      myid = "",
      mysale = "",
      myimage = "", role="";
  String email = "", password = "";
  final _formkey = GlobalKey<FormState>();

  TextEditingController useremailcontroller = new TextEditingController();
  TextEditingController usernamecontroller = new TextEditingController();
  TextEditingController userpasswordcontroller = new TextEditingController();

  getThisUserInfo() async {
    QuerySnapshot querySnapshot = await DatabaseMethods().getUserbnyusername(
      useremailcontroller.text.replaceAll("@gmail.com", ""),
    );

    spend = "${querySnapshot.docs[0]["spend"]}";
    myname = "${querySnapshot.docs[0]["name"]}";
    myemail = "${querySnapshot.docs[0]["email"]}";
    myusername = "${querySnapshot.docs[0]["username"]}";
    myid = "${querySnapshot.docs[0]["Id"]}";
    mysale = "${querySnapshot.docs[0]["sale"]}";
    myimage = "${querySnapshot.docs[0]["Images"]}";
    role="${querySnapshot.docs[0]["Role"]}";
    await SharedPreferenceHelper().saveDisplayName(myname);
    await SharedPreferenceHelper().saveUserEmail(myemail);
    await SharedPreferenceHelper().saveUserId(myid);
    await SharedPreferenceHelper().saveUserProfileUrl(myimage);

    await SharedPreferenceHelper().saveUserSpendUrl(spend);
    await SharedPreferenceHelper().saveUserSaleUrl(mysale);
    await SharedPreferenceHelper().saveUserRole(role);

    print(spend);
    setState(() {});
  }

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      await  getThisUserInfo();
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Ongo()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("No User Found for that Email");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "No User Found for that Email",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
        );
      } else if (e.code == 'wrong-password') {
        print("Wrong Password Provided by User");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Wrong Password Provided by User",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
        );
      }
    }
  }

  registration() async {
    if (password != null) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        print(userCredential);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "Registered Successfully",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        );

        String Id = randomAlphaNumeric(10);
        await SharedPreferenceHelper().saveDisplayName(usernamecontroller.text);
        await SharedPreferenceHelper().saveUserEmail(useremailcontroller.text);
        await SharedPreferenceHelper().saveUserId(Id);
        await SharedPreferenceHelper().saveUserProfileUrl(
            "https://firebasestorage.googleapis.com/v0/b/barberapp-ebcc1.appspot.com/o/icon1.png?alt=media&token=0fad24a5-a01b-4d67-b4a0-676fbc75b34a");
        await SharedPreferenceHelper().saveUserPhone("0");
        await SharedPreferenceHelper().saveUserAddress("0");
        await SharedPreferenceHelper().saveUserSpendUrl("0");
        await SharedPreferenceHelper().saveUserSaleUrl("0");
        await SharedPreferenceHelper().saveUserFood("0");
        await SharedPreferenceHelper().saveUserTransport("0");
        await SharedPreferenceHelper().saveUserEntertainment("0");
        await SharedPreferenceHelper().saveUserShopping("0");

        Map<String, dynamic> userInfoMap = {
          "name": usernamecontroller.text,
          "username": useremailcontroller.text.replaceAll("@gmail.com", ""),
          "email": useremailcontroller.text,
          "Id": Id,
          "spend": 0,
          "sale": 0,
          "Images":
          "https://firebasestorage.googleapis.com/v0/b/barberapp-ebcc1.appspot.com/o/icon1.png?alt=media&token=0fad24a5-a01b-4d67-b4a0-676fbc75b34a",
          "Role":""
        };

        DatabaseMethods().addUserDetail(userInfoMap, Id).then((value) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Choose(id: Id,)));
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print("Password Provided is too Weak");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Password Provided is too Weak",
                style: TextStyle(
                    fontSize: 18.0, color: Color.fromARGB(255, 17, 12, 12)),
              ),
            ),
          );
        } else if (e.code == 'email-already-in-use') {
          print("Account Already exists");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Account Already exists",
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
          child: Form(
            key: _formkey,
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
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Name';
                        }
                        return null;
                      },
                      controller: usernamecontroller,
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
                TextFormField(
                  controller: useremailcontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Email';
                    } else if (!value.contains('@')) {
                      return 'Please Enter Valid Email';
                    }
                    return null;
                  },
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
                TextFormField(
                  controller: userpasswordcontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Password';
                    }
                    return null;
                  },
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
                    if (_formkey.currentState!.validate()) {
                      setState(() {
                        email = useremailcontroller.text;
                        name ? myname = usernamecontroller.text : "";
                        password = userpasswordcontroller.text;
                      });
                    }

                    name ? registration() : userLogin();
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      decoration: BoxDecoration(
                          color: Color(0xFF60b876),
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                        child: Text(
                          name ? "Register" : "Login",
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
      ),
    );
  }
}
