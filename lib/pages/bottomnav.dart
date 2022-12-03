import 'package:flutter/material.dart';
import 'package:myreceiptapp/pages/barcode.dart';
import 'package:myreceiptapp/pages/dashboard_costumer.dart';
import 'package:myreceiptapp/pages/myreceipt.dart';
import 'package:myreceiptapp/pages/myspending.dart';
import 'package:myreceiptapp/pages/profile.dart';

class Bottombar extends StatefulWidget {
  Bottombar({Key? key}) : super(key: key);

  @override
  State<Bottombar> createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  int currentTabIndex = 0;
  late List<Widget> pages;

  late Widget currentPage;
  late DashboardCostumer dashboardCostumer;

  late BarcodeScan scan;
  late MyReceipt myReceipt;
  late Myspending myspending;
  late Profile profile;

  @override
  void initState() {
    super.initState();
    scan = BarcodeScan();
    myReceipt = MyReceipt();
    myspending = Myspending();
    dashboardCostumer = DashboardCostumer();
    profile = Profile();
    pages = [dashboardCostumer, scan, myReceipt, myspending, profile];
    currentPage = dashboardCostumer;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: TextStyle(color: Color(0xFF42A132)),
          showSelectedLabels: true,
          fixedColor: Color(0xFF42A132),
          unselectedLabelStyle: TextStyle(color: Colors.black),
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
              icon: Icon(Icons.home_outlined),
              label: "Home",
              activeIcon: Icon(Icons.home_outlined, color: Color(0xFF42A132)),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.qr_code_scanner_rounded),
              label: "Scan Receipts",
              activeIcon:
              Icon(Icons.qr_code_scanner_rounded, color: Color(0xFF42A132)),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt),
              label: "MyReceipts",
              activeIcon: Icon(Icons.receipt, color: Color(0xFF42A132)),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.currency_exchange),
              label: "MySpendings",
              activeIcon:
              Icon(Icons.currency_exchange, color: Color(0xFF42A132)),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
              activeIcon: Icon(Icons.person, color: Color(0xFF42A132)),
            )
          ]),
      body: currentPage,
    );
  }
}
