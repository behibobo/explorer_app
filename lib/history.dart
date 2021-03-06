import 'package:explorer/loplob_result.dart';
import 'package:explorer/styles/main.dart';
import 'package:explorer/models/found_treasure.dart';
import 'package:explorer/models/user_loplob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'models/item.dart';
import 'providers/item.dart';
import 'package:flutter_svg/svg.dart';

final String diamondIcon = 'images/diamond.svg';
final String loplobIcon = 'images/loplob.svg';
final String giftIcon = 'images/gifts.svg';
final String homeIcon = 'images/home.svg';
final String personIcon = 'images/person.svg';
final String codeIcon = 'images/qrcode.svg';
final String happyIcon = 'images/happy.svg';
final String sadIcon = 'images/sad.svg';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PagewiseSliverListExample();
  }
}

class PagewiseSliverListExample extends StatelessWidget {
  static const int PAGE_SIZE = 8;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              backgroundColor: yellow,
              elevation: 0.0,
              title: Text(
                "خریدهای من",
                style: TextStyle(
                    fontFamily: "Vazir",
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
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
              bottom: TabBar(tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'خریدها',
                      style: TextStyle(
                        fontFamily: "Vazir",
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SvgPicture.asset(
                      codeIcon,
                      width: 20,
                      height: 20,
                      color: Colors.black,
                    )
                  ],
                )),
                Tab(
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'گنج ها',
                      style: TextStyle(
                        fontFamily: "Vazir",
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SvgPicture.asset(
                      diamondIcon,
                      width: 20,
                      height: 20,
                      color: Colors.black,
                    )
                  ],
                )),
                Tab(
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'لپ لب ها',
                      style: TextStyle(
                        fontFamily: "Vazir",
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SvgPicture.asset(
                      loplobIcon,
                      width: 20,
                      height: 20,
                      color: Colors.black,
                    )
                  ],
                )),
              ]),
            ),
            body: TabBarView(
              children: [
                ItemsList(),
                TreasureList(),
                LoplobList(),
              ],
            )));
  }
}

class ItemsList extends StatelessWidget {
  static const int PAGE_SIZE = 10;

  @override
  Widget build(BuildContext context) {
    return PagewiseListView(
        pageSize: PAGE_SIZE,
        itemBuilder: this._itemBuilder,
        pageFuture: (pageIndex) =>
            ItemProvider.getItems(pageIndex * PAGE_SIZE, PAGE_SIZE));
  }

  Widget _itemBuilder(context, Item entry, _) {
    Widget leading;
    if(entry.hasGift) {
      leading = SvgPicture.asset(
              happyIcon,
              width: 50,
              height: 50,
              color: Colors.lightGreen[200],
            );
    } else {
      leading = SvgPicture.asset(
              sadIcon,
              width: 40,
              height: 40,
              color: Colors.red[200],
            );
    }
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

class TreasureList extends StatelessWidget {
  static const int PAGE_SIZE = 10;

  @override
  Widget build(BuildContext context) {
    return PagewiseListView(
        pageSize: PAGE_SIZE,
        itemBuilder: this._itemBuilder,
        pageFuture: (pageIndex) =>
            ItemProvider.getFoundTreasures(pageIndex * PAGE_SIZE, PAGE_SIZE));
  }

  Widget _itemBuilder(context, FoundTrasure entry, _) {
    return Column(
      children: <Widget>[
        ListTile(
            trailing: SvgPicture.asset(
              diamondIcon,
              width: 24,
              height: 24,
              color: Colors.black,
            ),
            leading: SvgPicture.asset(
              codeIcon,
              width: 20,
              height: 20,
              color: Colors.black,
            ),
            title: Text(
              '${entry.value}',
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
                  '${entry.date}',
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

class LoplobList extends StatelessWidget {
  static const int PAGE_SIZE = 10;

  @override
  Widget build(BuildContext context) {
    return PagewiseListView(
        pageSize: PAGE_SIZE,
        itemBuilder: this._itemBuilder,
        pageFuture: (pageIndex) =>
            ItemProvider.getUserLoplobs(pageIndex * PAGE_SIZE, PAGE_SIZE));
  }

  Widget _itemBuilder(context, UserLoplob entry, _) {
    Widget leading;
    if(entry.won) {
      leading = SvgPicture.asset(
              happyIcon,
              width: 50,
              height: 50,
              color: Colors.lightGreen[200],
            );
    } else {
      leading = SvgPicture.asset(
              sadIcon,
              width: 40,
              height: 40,
              color: Colors.red[200],
            );
    }
    return Column(
      children: <Widget>[
        ListTile(
            trailing: SvgPicture.asset(
              loplobIcon,
              width: 24,
              height: 24,
              color: Colors.black,
            ),
            leading: leading,
            title: Text(
              '${entry.value}',
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
                  '${entry.date}',
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
