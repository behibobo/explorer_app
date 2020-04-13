import 'package:explorer/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'models/item.dart';
import 'providers/item.dart';
import 'package:explorer/styles/main.dart';

class GiftList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PagewiseSliverListExample();
  }
}

class PagewiseSliverListExample extends StatelessWidget {
  static const int PAGE_SIZE = 8;
  bool odd = false;
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      appBar: mainAppbar(context, "لیست جوایز"),
    body: CustomScrollView(
      
      slivers: [
      PagewiseSliverList(
          pageSize: PAGE_SIZE,
          itemBuilder: this._itemBuilder,
          pageFuture: (pageIndex) =>
              ItemProvider.getGiftItems(pageIndex * PAGE_SIZE, PAGE_SIZE))
      // BackendService.getPosts(pageIndex * PAGE_SIZE, PAGE_SIZE))
    ]));
  }

  Widget _itemBuilder(context, Item entry, _) {
    odd = !odd;
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 4.0),
          // decoration: new BoxDecoration (
          //     color: (odd)?  Colors.grey[200] : Colors.white
          //   ),
        child: ListTile(
            
            trailing: Image.network(entry.itemImage),
            leading: Text(
              '${entry.totalGift}',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Vazir"),
            ),
            title: Text(
              '${entry.itemName}',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Vazir"),
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                
                
                Text(
                  '${entry.giftValue} ریال',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Vazir"),
                ),
                
              ],
            ))),
            Divider()
      ],
    );
  }
}
