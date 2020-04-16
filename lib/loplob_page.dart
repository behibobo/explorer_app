import 'dart:developer';

import 'package:explorer/loplob_result.dart';
import 'package:explorer/models/loplob.dart';
import 'package:explorer/models/loplobs.dart';
import 'package:explorer/providers/item.dart';
import 'package:explorer/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:random_color/random_color.dart';

class LoplobPage extends StatefulWidget {
  int id;
  LoplobPage(this.id);
  @override
  _LoplobState createState() => _LoplobState();
}

class _LoplobState extends State<LoplobPage> with TickerProviderStateMixin {
  int id;
  @override
  void initState() {
    super.initState();
    this.id = widget.id;
  }

  final String loplobIcon = 'images/loplob.svg';
  final String giftIcon = 'images/gifts.svg';

  RandomColor _randomColor = RandomColor();

  Future<List<Loplob>> _getLoplobs() async {
    ItemProvider prov = new ItemProvider();
    return await prov.getLoplob(this.id);
  }

  Future<void> purchase(uuid, requiredCredit) async {
    ItemProvider prov = new ItemProvider();
    Map res = await prov.purchaseloplob(uuid, requiredCredit);
    Navigator.of(context).push(
      MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return LoplobResult(res);
        },
        fullscreenDialog: true,
      ),
    );
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
              Color _color = _randomColor.randomColor(
                colorHue: ColorHue.multiple(
                    colorHues: [ColorHue.red, ColorHue.blue]));
              col.add(new GestureDetector(
                  onTap: () {
                    Loplob item = snapshot.data[i];
                    purchase(item.uuid, item.requiredCredit);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white54,
                      border: Border.all(
                          color: Colors.white,
                          width: 0,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[200],
                            offset: Offset(0, 0),
                            blurRadius: 3,
                            spreadRadius: 1)
                      ],
                    ),
                    margin: new EdgeInsets.all(5.0),
                    width: 50,
                    height: 50,
                    padding: EdgeInsets.all(14),
                    child: SvgPicture.asset(
                      loplobIcon,
                      width: 20,
                      height: 20,
                      color: _color,
                    ),
                  )));
            }
            row.add(new TableRow(children: col));
          }

          return Scaffold(
              appBar: AppBar(
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  centerTitle: true,
                  title: Text(
                    "لپ لب",
                    style: TextStyle(
                        fontFamily: "Vazir",
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )),
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
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              )
            ],
          );
        }
      },
    );
  }
}
