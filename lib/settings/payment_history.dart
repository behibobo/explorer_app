import 'package:flutter/material.dart';
import 'package:explorer/widgets/appbar.dart';

class PaymentHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    title: Text(
      "لیست تراکنش ها",
      style: TextStyle(fontFamily: "Vazir", fontSize: 14, color: Colors.black),
    ),
    centerTitle: true,
    // actions: <Widget>[
    //   IconButton(
    //     icon: Icon(
    //       Icons.search,
    //       color: Colors.blue,
    //     ),
    //     onPressed: () {},
    //   )
    // ],
  ),
      body: displayAccoutList()
    );
  }


  Container accountItems(
          String item, String charge, String dateString, String type,
          {Color oddColour = Colors.white}) =>
      Container(
        decoration: BoxDecoration(color: oddColour),
        padding:
            EdgeInsets.only(top: 20.0, bottom: 20.0, left: 5.0, right: 5.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(item, style: TextStyle(fontFamily: "Vazir", fontSize: 12.0)),
                Text(charge, style: TextStyle(fontFamily: "Vazir",fontSize: 14.0))
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(dateString,
                    style: TextStyle(color: Colors.grey, fontFamily: "Vazir", fontSize: 12.0)),
                Text(type, style: TextStyle(fontFamily: "Vazir", color: Colors.grey, fontSize: 12.0))
              ],
            ),
          ],
        ),
      );

  displayAccoutList() {
    return Container(
      margin: EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          accountItems("Trevello App", r"ریال 4946", "1399-01-01", "اسکن",
              oddColour: const Color(0xFFF7F7F9)),
          accountItems(
              "Creative Studios", r"ریال 5428", "1399-01-03", "اسکن"),
          accountItems("Amazon EU", r"ریال 746", "1399-01-04", "شارژ حساب",
              oddColour: const Color(0xFFF7F7F9)),
          accountItems(
              "Creative Studios", r"ریال 14526", "1399-01-05", "شارژ حساب"),
          accountItems(
              "Book Hub Society", r"ریال 2876", "1399-01-06", "اسکن",
              oddColour: const Color(0xFFF7F7F9)),
        ],
      ),
    );
  }
}
 