import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardCostumerState();
}

class _DashboardCostumerState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Hello",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 28.0),
                        ),
                        Image.asset(
                          "images/wave.png",
                          height: 35,
                          width: 35,
                        )
                      ],
                    ),
                    Text(
                      "John Doe",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 20.0),
                    ),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "images/men.jpg",
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 40.0,
            ),
            Text(
              "Your Insights",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0),
            ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Color(0xFF42A232),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "TODAY'S EXPENDITURE",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "257",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(34, 213, 102, 0.54),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Text(
                "1",
                style: TextStyle(color: Color.fromRGBO(34, 213, 102, 0.54)),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              "Your Insights",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Image.asset(
                "images/scannew.png",
                height: 160,
                width: 160,
              ),
              Image.asset(
                "images/past.png",
                height: 160,
                width: 160,
              )
            ])
          ],
        ),
      ),
    );
  }
}
