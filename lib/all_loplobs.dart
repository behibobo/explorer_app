import 'dart:developer';

import 'package:explorer/home.dart';
import 'package:explorer/loplob_page.dart';
import 'package:explorer/models/loplob.dart';
import 'package:explorer/models/loplobs.dart';
import 'package:explorer/providers/item.dart';
import 'package:explorer/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AllLoplobs extends StatefulWidget {
  @override
  _LoplobState createState() => _LoplobState();
}

class _LoplobState extends State<AllLoplobs> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  final String loplobIcon = 'images/loplob.svg';
  final String giftIcon = 'images/gifts.svg';

  Future<List<Loplobs>> _getLoplobs() async {
    ItemProvider prov = new ItemProvider();
    return await prov.getAllLoplobs();
  }

  @override
  Widget build(BuildContext context) {
    final colors = <Color>[
      Colors.white,
      Colors.blue,
      Colors.greenAccent,
      Colors.yellow,
      Colors.purpleAccent,
      Colors.blue,
      Colors.greenAccent,
      Colors.yellow,
      Colors.purpleAccent,
    ];
    return Scaffold(
        appBar: mainAppbar(context, "لپ لب"),
        body: SingleChildScrollView(
            child: FutureBuilder(
          future: _getLoplobs(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            List<Widget> children = [
              Text(
                "توضیح در مورد لپ لب و جوایز آن",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontFamily: "Vazir",
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 20,
              )
            ];

            if (snapshot.hasData) {
              for (final item in snapshot.data) {
                children.add(
                  GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                    MaterialPageRoute<Null>(
                      builder: (BuildContext context) {
                        return LoplobPage(item.id);
                      },
                      fullscreenDialog: true,
                    ),
                  );
                  },
                  child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                      color: colors[item.id],
                      borderRadius: BorderRadius.circular(24)),
                  padding: EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(children: <Widget>[
                        Text(
                        "حداقل اعتبار: ${item.requiredCredit}",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Vazir",
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "تعداد لپ لب: ${item.qty}",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Vazir",
                            fontSize: 12),
                      ),
                      ],),
                      
                      SvgPicture.asset(
                        loplobIcon,
                        width: 80,
                        color: Colors.white,
                      )
                    ],
                  ),
                )));
                
              }
            } else if (snapshot.hasError) {
              children = <Widget>[
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                )
              ];
            } else {
              children = <Widget>[
                SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'درحال دریافت اطلاعات',
                    style: TextStyle(
                      fontFamily: "Vazir",
                      fontSize: 12,
                    ),
                  ),
                )
              ];
            }

            return Container(
              padding: EdgeInsets.all(10),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: children,
              )),
            );
          },
        )));
  }
}
