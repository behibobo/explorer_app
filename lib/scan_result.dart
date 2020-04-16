import 'dart:developer';

import 'package:explorer/all_loplobs.dart';
import 'package:explorer/history.dart';
import 'package:explorer/providers/item.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter_svg/svg.dart';

final String diamondIcon = 'images/diamond.svg';
final String loplobIcon = 'images/loplob.svg';

class ScanResult extends StatefulWidget {
  Map res;

  ScanResult(this.res);
  @override
  _LoplobState createState() => _LoplobState();
}

class _LoplobState extends State<ScanResult> with TickerProviderStateMixin {
  static AudioCache player = new AudioCache();
    
  @override
  void initState() {
    super.initState();
    const alarmAudioPath = "sound.mp3";
    player.play(alarmAudioPath);
  }

  

  Future<void> purchase(uuid, requiredCredit) async {
    ItemProvider prov = new ItemProvider();
    Map res = await prov.purchaseloplob(uuid, requiredCredit);
    log(res["value"].toString());
  }

  @override
  Widget build(BuildContext context) {
    String icon;
    Color color;

    if (widget.res["success"]) {
      icon = 'images/happy.svg';
      color = Colors.green;

    } else {
      icon = 'images/sad.svg';
      color = Colors.red;
    }
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => AllLoplobs()));
              }),
          elevation: 0.0,
          title: Text("",
              style: TextStyle(
                  fontFamily: "Vazir", fontSize: 14, color: Colors.black)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      icon,
                      width: 150,
                      height: 150,
                      color: color,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                        child: Text(
                      widget.res["message"],
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: "Vazir", 
                      fontSize: 12),
                    )),
                    SizedBox(
                      height: 30,
                    ),
                    FlatButton(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => History()));
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          child: Text(
                            "لیست خریدها",
                            style: TextStyle(
                              fontFamily: "Vazir",
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ))
                  ],
                )))));
  }
}
