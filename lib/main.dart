import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myreceiptapp/pages/bottomnav.dart';
import 'package:myreceiptapp/pages/choose.dart';
import 'package:myreceiptapp/pages/login.dart';
import 'package:myreceiptapp/service/auth.dart';
import 'package:myreceiptapp/service/database.dart';
import 'package:myreceiptapp/service/shared_pref.dart';
import 'package:myreceiptapp/vendors/vendornav.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
            future: AuthMethods().getCurrentUser(),
            builder: (context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return Ongo();
              } else {
                return logIn();
              }
            }));
  }
}

class Ongo extends StatefulWidget {
  Ongo({Key? key}) : super(key: key);

  @override
  State<Ongo> createState() => _OngoState();
}

class _OngoState extends State<Ongo> {
  String role = "";

  gethesharedpref() async {
    role = (await SharedPreferenceHelper().getUserRole())!;
    setState(() {});
  }

  ontheload() async {
    await gethesharedpref();
    print(role);
    role == "Costumer"
        ? Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Bottombar()))
        : Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => VendorNav()));
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
