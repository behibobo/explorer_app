import 'dart:developer';

import 'package:explorer/activate.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:explorer/delayed_animation.dart';
import 'package:provider/provider.dart';
import 'package:explorer/providers/auth.dart';

const Color darkBlue = Color.fromRGBO(26, 31, 60, 1.0);
const Color yellow = Color.fromRGBO(255, 204, 0, 1.0);
const Color highlight = Color.fromRGBO(255, 255, 255, 0.2);

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final int delayedAmount = 0;

  @override
  void initState() {
    super.initState();
  }

  String mobile;
  String password;
  String message = '';
  bool response = false;

  Future<void> logIn() async {
    final form = _formKey.currentState;
    if (form.validate()) {
      response = await Provider.of<AuthProvider>(context).login(mobile);
      if (response) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => Activate(mobile)));
      }
    }

    // Navigator.of(context).push(MaterialPageRoute(
    //                                   builder: (_) => MainPage()));
  }

  Widget HomePage() {
    return new Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: yellow,
          image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.1), BlendMode.dstATop),
            image: AssetImage('images/map.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: new Column(children: <Widget>[
          Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.only(top: 0.0),
                child: Center(
                  child: DelayedAnimation(
                      child: FlareActor("images/scan.flr",
                          alignment: Alignment.center,
                          fit: BoxFit.contain,
                          animation: "Primeira Animacao")),
                ),
              )),
          Expanded(
            flex: 2,
            child: new Column(
              children: <Widget>[
                SizedBox(
                  height: 30.0,
                ),
                DelayedAnimation(
                  child: Text(
                    "میلیاردر شو ",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontFamily: 'Vazir',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                  delay: delayedAmount + 1000,
                ),
                SizedBox(
                  height: 10.0,
                ),
                DelayedAnimation(
                  child: Text(
                    "به کاوشگر خوش آمدید",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontFamily: 'Vazir',
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  delay: delayedAmount + 2000,
                ),
                SizedBox(
                  height: 20.0,
                ),
                
                DelayedAnimation(
                    delay: delayedAmount + 3000,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          left: 30.0, right: 30.0, top: 10.0),
                      alignment: Alignment.center,
                      child: new Row(
                        children: <Widget>[
                          new Expanded(
                            child: new FlatButton(
                              shape: new RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                      style: BorderStyle.solid),
                                  borderRadius:
                                      new BorderRadius.circular(30.0)),
                              color: Colors.white,
                              onPressed: () => gotoLogin(),
                              child: new Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15.0,
                                  horizontal: 15.0,
                                ),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Expanded(
                                      child: Text(
                                        "شروع",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Vazir',
                                            fontSize: 14.0,
                                            color: darkBlue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          )
        ]));
  }

  Widget LoginPage() {
    return new Material(
        child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.05), BlendMode.dstATop),
                image: AssetImage('images/map.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Form(
              key: _formKey,
              child: new Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(50, 50, 50, 10),
                    child: Center(
                      child: Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 50.0,
                      ),
                    ),
                  ),
                  new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new Padding(
                          padding: const EdgeInsets.only(right: 40.0),
                          child: new Text(
                            "شماره موبایل",
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Vazir',
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  new Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(
                        left: 40.0, right: 40.0, top: 0.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: Colors.grey[400],
                            width: 0.5,
                            style: BorderStyle.solid),
                      ),
                    ),
                    padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              mobile = value.trim();
                              if (value.isEmpty) {
                                return 'شماره موبایل را وارد کنید';
                              }
                              return null;
                            },
                            textAlign: TextAlign.right,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  new Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(
                        left: 30.0, right: 30.0, top: 20.0),
                    alignment: Alignment.center,
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new FlatButton(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            color: yellow,
                            onPressed: logIn,
                            child: new Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 15.0,
                                horizontal: 15.0,
                              ),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Expanded(
                                    child: Text(
                                      "بعدی",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Vazir',
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }

  Widget SignupPage() {
    return new Material(
        child: Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.05), BlendMode.dstATop),
          image: AssetImage('images/map.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: new Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(50, 50, 50, 10),
            child: Center(
              child: Icon(
                Icons.search,
                color: darkBlue,
                size: 50.0,
              ),
            ),
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(right: 40.0),
                  child: new Text(
                    "شماره موبایل",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: darkBlue,
                      fontFamily: 'Vazir',
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 0.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: darkBlue, width: 0.5, style: BorderStyle.solid),
              ),
            ),
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  child: TextField(
                    obscureText: false,
                    textAlign: TextAlign.right,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(right: 40.0),
                  child: new Text(
                    "کلمه عبور",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: darkBlue,
                        fontSize: 12.0,
                        fontFamily: 'Vazir'),
                  ),
                ),
              ),
            ],
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 0.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: darkBlue, width: 0.5, style: BorderStyle.solid),
              ),
            ),
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  child: TextField(
                    obscureText: true,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '*********',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(right: 40.0),
                  child: new Text(
                    "تکرار کلمه عبور",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: darkBlue,
                        fontSize: 12.0,
                        fontFamily: 'Vazir'),
                  ),
                ),
              ),
            ],
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 0.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: darkBlue, width: 0.5, style: BorderStyle.solid),
              ),
            ),
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  child: TextField(
                    obscureText: true,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '*********',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          // new Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: <Widget>[
          //     Padding(
          //       padding: const EdgeInsets.only(right: 20.0),
          //       child: new FlatButton(
          //         child: new Text(
          //           "حساب کاربری دارم",
          //           style: TextStyle(
          //               fontWeight: FontWeight.bold,
          //               color: darkBlue,
          //               fontSize: 12.0,
          //               fontFamily: 'Vazir'),
          //           textAlign: TextAlign.end,
          //         ),
          //         onPressed: () => {},
          //       ),
          //     ),
          //   ],
          // ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    color: darkBlue,
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Activate(mobile)),
                      )
                    },
                    child: new Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 15.0,
                      ),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Expanded(
                            child: Text(
                              "ایجاد حساب کاربری",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Vazir',
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  gotoLogin() {
    //controller_0To1.forward(from: 0.0);
    _controller.animateToPage(
      0,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }

  gotoSignup() {
    //controller_minus1To0.reverse(from: 0.0);
    _controller.animateToPage(
      2,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }

  PageController _controller =
      new PageController(initialPage: 1, viewportFraction: 1.0);

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: Container(
            height: MediaQuery.of(context).size.height,
            child: PageView(
              controller: _controller,
              physics: new AlwaysScrollableScrollPhysics(),
              children: <Widget>[LoginPage(), HomePage()],
              scrollDirection: Axis.horizontal,
            )));
  }
}
