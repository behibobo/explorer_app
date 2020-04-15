import 'dart:developer';

import 'package:explorer/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Loplob extends StatefulWidget {
  @override
  _LoplobState createState() => _LoplobState();
}

class _LoplobState extends State<Loplob> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  final String loplobIcon = 'images/loplob.svg';
  final String giftIcon = 'images/gifts.svg';

  @override
  Widget build(BuildContext context) {
    final row = <TableRow>[];

    for (var i = 1; i <= 12; i += 4) {
      final col = <Widget>[];
      for (var j = i; j <= i + 3; j++) {
        col.add(new GestureDetector(
            onTap: () {
              log("$j");
            },
            child: Container(
              color: Colors.black12,
              margin: new EdgeInsets.all(5.0),
              width: 50,
              height: 50,
              padding: EdgeInsets.all(10),
              child: SvgPicture.asset(
                giftIcon,
                width: 24,
                height: 24,
                color: Colors.black,
              ),
            )));
      }
      row.add(new TableRow(children: col));
    }

    return Scaffold(
        appBar: mainAppbar(context, "کاوشگر"),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: Table(
              children: row,
            ),
          ),
        ])));
  }
}
