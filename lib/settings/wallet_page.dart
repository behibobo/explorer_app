import 'package:explorer/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> with TickerProviderStateMixin {
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
    return Material(
      
      child: SafeArea(
        child: LayoutBuilder(
          builder: (builder, constraints) => SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: 
                Container(
                color: Colors.white,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            
                            CloseButton()
                          ],
                        ),
                      ),
                      Text('موجودی حساب شما',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: 'Sahel',
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                       ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(width: 8.0),
                            Text('540000',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontFamily: "Vazir",
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                      
                      Flexible(
                        child: Container(
                          height: 232,
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                             Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  padding: const EdgeInsets.all(16.0),
                                  width: 140,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Color.fromRGBO(255,215,0,1.0),
                                      width: 3),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(bottom:5.0),
                                        child: Image.asset("images/gold.png"),
                                      ),
                                      Padding(
                                       padding: const EdgeInsets.symmetric(vertical:2.0),
                                        child: Text('بسته طایی',
                                        textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                fontFamily: 'Sahel',
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical:2.0),
                                        child: Text('توضیحات بسته',
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Sahel',
                                                fontSize: 12.0,)),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  padding: const EdgeInsets.all(16.0),
                                  width: 140,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Color.fromRGBO(192,192,192,1.0),
                                      width: 3),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(bottom:5.0),
                                        child: Image.asset("images/silver.png"),
                                      ),
                                      Padding(
                                       padding: const EdgeInsets.symmetric(vertical:2.0),
                                        child: Text('بسته نقره ای',
                                        textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                fontFamily: 'Sahel',
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical:2.0),
                                        child: Text('توضیحات بسته',
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Sahel',
                                                fontSize: 12.0,)),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  padding: const EdgeInsets.all(16.0),
                                  width: 140,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Color.fromRGBO(177,86,15,1.0),
                                      width: 3),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(bottom:5.0),
                                        child: Image.asset("images/bronze.png"),
                                      ),
                                      Padding(
                                       padding: const EdgeInsets.symmetric(vertical:2.0),
                                        child: Text('بسته برنزی',
                                        textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                fontFamily: 'Sahel',
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical:2.0),
                                        child: Text('توضیحات بسته',
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Sahel',
                                                fontSize: 12.0,)),
                                      ),
                                    ],
                                  ),
                                )
              ]),
                      )
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 24.0, left: 24.0, right: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                  ListTile(
                            title: Text(
                              'لیست سوابق خرید و  پرداخت',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Vazir',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            leading: Icon(Icons.payment, color: Colors.black),
                            onTap: () {},
                          ),
                          ListTile(
                            title: Text(
                              'لیست کدهای اسکن شده',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Vazir',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            leading: Icon(Icons.list, color: Colors.black),
                            onTap: () {},
                          )]))
                  ]),
                  ),
                ),
              ),
        ),
      ),
    );
  }
}

class YellowDollarButton extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double height = size.height;
    double width = size.width;

    canvas.drawCircle(Offset(width / 2, height / 2), height / 2,
        Paint()..color = Color.fromRGBO(253, 184, 70, 0.2));
    canvas.drawCircle(Offset(width / 2, height / 2), height / 2 - 4,
        Paint()..color = Color.fromRGBO(253, 184, 70, 0.5));
    canvas.drawCircle(Offset(width / 2, height / 2), height / 2 - 12,
        Paint()..color = Color.fromRGBO(253, 184, 70, 1));
    canvas.drawCircle(Offset(width / 2, height / 2), height / 2 - 16,
        Paint()..color = Color.fromRGBO(255, 255, 255, 0.1));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
