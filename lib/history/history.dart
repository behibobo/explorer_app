import 'package:explorer/models/item.dart';
import 'package:explorer/history/HistoryTile.dart';
import 'package:flutter/material.dart';
import 'package:explorer/helper.dart';
import 'package:explorer/providers/item.dart';

import '../splash.dart';

class History extends StatelessWidget {
  Future<List<Item>> getItems() async {
    ItemProvider provider = new ItemProvider();
    List<Item> items = await provider.getItems();
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('محصولات اسکن شده',
              style: TextStyle(
                  fontFamily: 'Vazir',
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
        ),
        backgroundColor: yellow,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [
              0.2,
              0.3,
              0.5,
              0.8
            ],
                colors: [
          Color.fromRGBO(249, 249, 249, 1),
          Color.fromRGBO(241, 241, 241, 1),
          Color.fromRGBO(233, 233, 233, 1),
          Color.fromRGBO(222, 222, 222, 1),
        ])),
        child: FutureBuilder<List<Item>>(
            future: getItems(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext ctxt, int index) =>
                        HistoryTile(item: snapshot.data[index]));
              } else {
                return Center(
                    child: Column(children: [
                  Helper.bigPaddingNoBottom(Text('Loading...')),
                  Helper.bigPaddingNoBottom(CircularProgressIndicator())
                ]));
              }
            }),
      ),
    );
  }
}
