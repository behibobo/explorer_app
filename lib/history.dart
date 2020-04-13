import 'package:explorer/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'models/item.dart';
import 'providers/item.dart';
import 'package:flutter_svg/svg.dart';


class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PagewiseSliverListExample();
  }
}

class PagewiseSliverListExample extends StatelessWidget {
  static const int PAGE_SIZE = 8;
  final String codeIcon = 'images/qrcode.svg';

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      appBar: AppBar(
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    title: Text(
      "خریدهای من",
      style: TextStyle(fontFamily: "Vazir", fontSize: 14, color: Colors.black),
    ),
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
  ),
    body: CustomScrollView(
      
      slivers: [
      PagewiseSliverList(
          pageSize: PAGE_SIZE,
          itemBuilder: this._itemBuilder,
          pageFuture: (pageIndex) =>
              ItemProvider.getItems(pageIndex * PAGE_SIZE, PAGE_SIZE))
      // BackendService.getPosts(pageIndex * PAGE_SIZE, PAGE_SIZE))
    ]));
  }

  Widget _itemBuilder(context, Item entry, _) {
    return Column(
      children: <Widget>[
        ListTile(
            trailing: Image.network(entry.itemImage),
            leading: SvgPicture.asset(
                codeIcon,
                width: 20,
                height: 20,
                color: Colors.black,
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
                  '${entry.scanDate}',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Vazir"),
                ),
                
              ],
            )),
        Divider()
      ],
    );
  }
}
