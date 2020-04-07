import 'package:explorer/models/item.dart';
import 'package:explorer/splash.dart';
import 'package:flutter/material.dart';
import 'package:explorer/helper.dart';

import '../splash.dart';
import '../splash.dart';
import '../splash.dart';

class HistoryTileState extends State<HistoryTile> {
  final Item item;
  bool _expanded;
  BuildContext _context;
  DateTime _now = DateTime(2019, 12, 1);

  HistoryTileState(this.item) {
    this._expanded = false;
  }

  @override
  Widget build(BuildContext context) {
    this._context = context;
    ThemeData theme = Theme.of(_context);

    return GestureDetector(
        onTap: () {
          setState(() {
            this._expanded = !this._expanded;
          });
        },
        child: Helper.bigPaddingNoBottom(Card(
            color: Colors.white,
            borderOnForeground: true,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    child: Icon(
                      _expanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                      color: darkBlue,
                    ),
                    padding: EdgeInsets.all(10),
                  ),
                  Expanded(
                      flex: 2,
                      child: Padding(
                          padding: EdgeInsets.only(top: 15, bottom: 15),
                          child: AnimatedCrossFade(
                            duration: Duration(milliseconds: 300),
                            firstChild: _buildMaxiTile(),
                            secondChild: _buildMiniTile(),
                            crossFadeState: !_expanded
                                ? CrossFadeState.showFirst
                                : CrossFadeState.showSecond,
                            alignment: Alignment.topLeft,
                          ))),
                ]))));
  }

  Widget _buildMiniTile() {
    return Row(children: <Widget>[
      Expanded(
          flex: 3,
          child: Column(children: <Widget>[
            Center(
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          item.itemName,
                          style: TextStyle(color: darkBlue),
                          textAlign: TextAlign.center,
                        ))),
            Column(
              children: <Widget>[
                Center(
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Text(
                          item.itemBrand,
                          style: TextStyle(color: darkBlue),
                          textAlign: TextAlign.center,
                        ))),
                Center(
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 3.0, horizontal: 10),
                        color: yellow,
                        child: Text(
                          item.scanDate,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: darkBlue),
                          textAlign: TextAlign.center,
                        ))),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ])),
      Expanded(
          flex: 1,
          child: Container(
            height: 100,
            padding: EdgeInsets.all(10),
            child: Center(
              child: new Image.network(
                item.itemImage,
                fit: BoxFit.fill,
              ),
            ),
          )),
    ]);
  }

  bool _isPolicyNearExpiry() {
    return false;
  }

  bool _isPolicyExpired() {
    return false;
  }

  bool _isDateNearNow(DateTime date) {
    int diffDays = date.difference(_now).inDays;
    return diffDays < 60 && diffDays > -60;
  }

  Color _getColor({Color alternateDefaultColor}) {
    if (_isPolicyNearExpiry()) {
      return Theme.of(_context).errorColor;
    }
    return Theme.of(_context).textTheme.body1.color;
  }

  FontWeight _getFontWeight(DateTime date) {
    if (_isDateNearNow(date)) {
      return FontWeight.bold;
    }
    return FontWeight.normal;
  }

  Widget _buildMaxiTile() {
    var children = List<Widget>();

    children.add(Center(
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: Text(
              item.itemName,
              style: TextStyle(fontFamily: 'Vazir'),
              textAlign: TextAlign.center,
            ))));

    children.add(Center(
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10),
            color: darkBlue,
            child: Text(
              item.scanDate,
              style: TextStyle(fontWeight: FontWeight.bold, color: yellow),
              textAlign: TextAlign.center,
            ))));

    if (_isPolicyNearExpiry() && !_isPolicyExpired()) {
      children.add(Helper.padding(Row(
        children: <Widget>[
          Helper.padding(Icon(
            Icons.warning,
            color: Theme.of(_context).errorColor,
          )),
          Expanded(
              child: Text(
            'Nearing end of cover ()',
            style: TextStyle(fontFamily: 'Vazir'),
            textAlign: TextAlign.center,
          )),
          FlatButton(
            textTheme: ButtonTextTheme.normal,
            child: Text('RENEW', style: TextStyle(fontFamily: 'Vazir')),
            onPressed: () {},
            color: Theme.of(_context).buttonTheme.colorScheme.secondary,
          )
        ],
      )));
    }

    return Row(
      children: <Widget>[
        Expanded(flex: 3, child: Column(children: children)),
        Expanded(
            flex: 1,
            child: Container(
              height: 60,
              padding: EdgeInsets.all(10),
              child: Center(
                child: new Image.asset(
                  "images/qrcode.png",
                  fit: BoxFit.fill,
                ),
              ),
            ))
      ],
    );
  }
}

class HistoryTile extends StatefulWidget {
  HistoryTile({Key key, this.item}) : super(key: key);
  final Item item;

  @override
  HistoryTileState createState() {
    return HistoryTileState(this.item);
  }
}
