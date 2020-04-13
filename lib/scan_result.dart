import 'package:explorer/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScanResult extends StatefulWidget {
  final String message;
  ScanResult({Key key, this.message}) : super(key: key);
  @override
  _ScanResultState createState() => _ScanResultState();
}

class _ScanResultState extends State<ScanResult> with TickerProviderStateMixin {
  AnimationController animController;
  Animation<double> openOptions;
  
  List<User> users = [];

  getUsers() async {
    setState(() {
      users = [];
    });
  }

  @override
  void initState() {
    animController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    openOptions = Tween(begin: 0.0, end: 300.0).animate(animController);
    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0.0,
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (b, constraints) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                                color: Colors.yellowAccent,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(0, 3),
                                      blurRadius: 6)
                                ],
                                border: Border.all(
                                    width: 8.0, color: Colors.white)),
                            child: Image.asset("images/map.jpg"),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 72.0, vertical: 16.0),
                            child: Column(children: <Widget>[
                              Text(
                                "نام محصول",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "نام برند",
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              )
                            ]),
                          )
                        ],
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 16.0),
                        child: Text(
                          widget.message,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'Sahel',
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
