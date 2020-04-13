import 'dart:developer';

import 'package:explorer/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:explorer/providers/auth.dart';

const Color darkBlue = Color.fromRGBO(26, 31, 60, 1.0);
const Color yellow = Color.fromRGBO(255, 204, 0, 1.0);
const Color highlight = Color.fromRGBO(255, 255, 255, 0.2);

class Activate extends StatefulWidget {
  final String phoneNumber;
  Activate(this.phoneNumber);
  @override
  _ActivateState createState() => _ActivateState();
}



class _ActivateState extends State<Activate> with TickerProviderStateMixin {
  var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool response = false;

  Future<void> LogIn() async {
    log(currentText);
    response = await Provider.of<AuthProvider>(context).activate(widget.phoneNumber, currentText);
    log(response.toString());
    if (response) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => MainPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      key: scaffoldKey,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 30),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                child: FlareActor(
                  "images/otp.flr",
                  animation: "otp",
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.center,
                ),
              ),
              // Image.asset(
              //   'images/verify.png',
              //   height: MediaQuery.of(context).size.height / 3,
              //   fit: BoxFit.fitHeight,
              // ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                child: RichText(
                  text: TextSpan(
                      text: "شماره وارد شده: ",
                      children: [
                        TextSpan(
                            text: widget.phoneNumber,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Vazir",
                                fontSize: 12)),
                      ],
                      style: TextStyle(color: Colors.black54, fontSize: 15)),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 60),
                  child: PinCodeTextField(
                    length: 4,
                    obsecureText: false,
                    animationType: AnimationType.fade,
                    shape: PinCodeFieldShape.box,
                    animationDuration: Duration(milliseconds: 300),
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    inactiveColor: Color.fromRGBO(233, 199, 16, 1.0),
                    selectedColor: Color.fromRGBO(26, 31, 60, 1.0),
                    disabledColor: Color.fromRGBO(233, 199, 16, 1.0),
                    inactiveFillColor: Color.fromRGBO(233, 199, 16, 1.0),
                    activeColor: Color.fromRGBO(26, 31, 60, 1.0),
                    selectedFillColor: Color.fromRGBO(26, 31, 60, 1.0),
                    backgroundColor: Colors.blue.shade50,
                    fieldWidth: 50,
                    activeFillColor: Colors.white,
                    enableActiveFill: true,
                    autoFocus: true,
                    controller: textEditingController,
                    onCompleted: (v) {
                      print("Completed");
                    },
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        currentText = value;
                      });
                    },
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  hasError ? "*Please fill up all the cells properly" : "",
                  style: TextStyle(color: Colors.red.shade300, fontSize: 15),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "سریال را دریافت نکردید؟",
                    style: TextStyle(
                        fontFamily: "Vazir",
                        color: Colors.black54,
                        fontSize: 12),
                    children: [
                      TextSpan(
                          text: " ارسال مجدد",
                          recognizer: onTapRecognizer,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 13))
                    ]),
              ),
              SizedBox(
                height: 14,
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
                child: FlatButton(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  color: Colors.black,
                  onPressed: () async {
                    if (currentText.length != 4) {
                      setState(() {
                        hasError = true;
                      });
                    } else {
                      setState(() {
                        hasError = false;
                        LogIn();
                      });
                    }
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
                            "ورود به حساب کاربری",
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
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
