import 'dart:developer';

import 'package:explorer/models/loplobs.dart';
import 'package:explorer/providers/item.dart';
import 'package:explorer/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoplobPage extends StatefulWidget {
  @override
  _LoplobState createState() => _LoplobState();
}

class _LoplobState extends State<LoplobPage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  final String loplobIcon = 'images/loplob.svg';
  final String giftIcon = 'images/gifts.svg';

  Future<List<Loplobs>> _getLoplobs() async {
    ItemProvider prov = new ItemProvider();
    return await prov.getLoplobs();
  }

  Future<void> purchase(uuid) async {
    ItemProvider prov = new ItemProvider();
    return await prov.purchaseloplob(uuid);
  }

  @override
  Widget build(BuildContext context) {
    final row = <TableRow>[];

    return FutureBuilder(
      future: _getLoplobs(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
            for (var i = 1; i <= snapshot.data.length; i += 4) {
              final col = <Widget>[];
              for (var j = i; j <= i + 3; j++) {
                col.add(new GestureDetector(
                    onTap: () {
                      Loplobs item =  snapshot.data[i];
                      log(item.uuid);
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
        } else {
          SizedBox(
            child: CircularProgressIndicator(),
            width: 60,
            height: 60,
          );
        }
      },
    );
  }
}
