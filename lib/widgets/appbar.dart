import 'package:explorer/main_page.dart';
import 'package:flutter/material.dart';

Widget mainAppbar(BuildContext context, String text) {
  return AppBar(
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    backgroundColor: Colors.white,
    leading: IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.black),
      onPressed: () { Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => MainPage()));
      }),
    elevation: 0.0,
    title: Text(text, style: TextStyle(fontFamily: "Vazir", fontSize: 14, color: Colors.black)),
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
  );
}

