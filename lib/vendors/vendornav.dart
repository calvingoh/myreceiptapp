import 'package:flutter/material.dart';
import 'package:myreceiptapp/vendors/dashboard.dart';
import 'package:myreceiptapp/vendors/generate_receipt.dart';
import 'package:myreceiptapp/pages/profile.dart';
import 'package:myreceiptapp/vendors/report.dart';

class VendorNav extends StatefulWidget {
  VendorNav({Key? key}) : super(key: key);

  @override
  State<VendorNav> createState() => _VendorNavState();
}

class _VendorNavState extends State<VendorNav> {
  int currentTabIndex = 0;
  late List<Widget> pages;

  late Widget currentPage;

  late Dashboard dashboard;
  late generateReceipt generate;
  late Report report  ;
  late Profile profile;

  @override
  void initState() {
    super.initState();
    dashboard= Dashboard();
    generate= generateReceipt();
    report= Report();
    profile=Profile();
    pages = [dashboard, generate, report, profile];
    currentPage = dashboard;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(

          selectedLabelStyle:  const TextStyle(color: Color(0xFF42A132)),
          showSelectedLabels: true,
          fixedColor: const Color(0xFF42A132),
          unselectedLabelStyle: const TextStyle(color: Colors.black),
          showUnselectedLabels: true,
          onTap: (int index) {
            setState(() {
              currentTabIndex = index;
              currentPage = pages[index];
            });
          },
          currentIndex: currentTabIndex,
          type: BottomNavigationBarType.fixed,

          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",

              activeIcon: Icon(Icons.home, color: Color(0xFF42A132)),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.qr_code_scanner_outlined),
              label: "Generate Digital Receipt",

              activeIcon: Icon(Icons.qr_code_scanner_outlined, color: Color(0xFF42A132)),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.currency_exchange),
              label: "Report",
              activeIcon: Icon(Icons.currency_exchange,  color: Color(0xFF42A132)),


            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
              activeIcon: Icon(Icons.person,  color: Color(0xFF42A132)),
            )
          ]),
      body: currentPage,
    );
  }
}