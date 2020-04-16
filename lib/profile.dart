import 'package:explorer/history.dart';
import 'package:explorer/models/user.dart';
import 'package:explorer/settings/payment_history.dart';
import 'package:explorer/settings/settings_page.dart';
import 'package:explorer/styles/main.dart';
import 'package:explorer/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:explorer/providers/auth.dart';

final String codeIcon = 'images/qrcode.svg';
final String withdrawIcon = 'images/withdraw.svg';
final String settingIcon = 'images/setting.svg';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Future<User> _getProfile() async {
    return await Provider.of<AuthProvider>(context).profile();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppbar(context, "پروفایل"),
      body: SingleChildScrollView(
        child: FutureBuilder<User>(
      future: _getProfile(),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        List<Widget> children;

        if (snapshot.hasData) {
          children = <Widget>[
            _paypalCard(context, snapshot.data.credit),
            _activityList(context, snapshot.data),
          ];
        } else if (snapshot.hasError) {
          children = <Widget>[
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${snapshot.error}'),
            )
          ];
        } else {
          children = <Widget>[
            SizedBox(
              child: CircularProgressIndicator(),
              width: 60,
              height: 60,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text(
                'درحال دریافت اطلاعات',
                style: TextStyle(
                  fontFamily: "Vazir",
                  fontSize: 12,
                ),
              ),
            )
          ];
        }
        return Padding(
          padding: EdgeInsets.all(10),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          )),
        );
      },
    )));
  }
}

Container _paypalCard(context, credit) {
  return Container(
    margin: EdgeInsets.all(15),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 11),
    decoration: BoxDecoration(
      color: Colors.lightBlue,
      border:
          Border.all(color: Colors.white, width: 0, style: BorderStyle.solid),
      borderRadius: BorderRadius.all(
        Radius.circular(5.0),
      ),
      boxShadow: [
        BoxShadow(
            color: Colors.grey[300],
            offset: Offset(0, 3),
            blurRadius: 6,
            spreadRadius: 1)
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            
                Icon(Icons.wallpaper),
                Text(
                  'موجودی کیف پول',
                  style: TextStyle(
                      color: Colors.white, 
                      fontWeight: FontWeight.bold,
                      fontFamily: "Vazir", 
                      fontSize: 12),
                ),
              
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.asset('images/chip_thumb.png'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      'ریال',
                      style: TextStyle(fontFamily: "Vazir", 
                      color: Colors.white,
                      fontSize: 25),
                    ),
                    SizedBox(width: 13),
                    Text(
                      '${credit}',
                      style: TextStyle(
                          fontFamily: "Vazir",
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 35),
                    ),
                    SizedBox(width: 13),
                  ],
                ),
              ],
            )
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: <Widget>[
            SizedBox(
              height: 25,
              child: FlatButton(
                color: Colors.black,
                textColor: Colors.white,
                child: Text(
                  "گزارش تراکنش ها",
                  style: TextStyle(
                      fontFamily: "Vazir", 
                      color: Colors.white, 
                      fontSize: 11),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<Null>(
                      builder: (BuildContext context) {
                        return PaymentHistory();
                      },
                      fullscreenDialog: true,
                    ),
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            Spacer()
          ],
        ),
      ],
    ),
  );
}

ListView _activityList(context, user) {
  return ListView(
    shrinkWrap: true,
    physics: ClampingScrollPhysics(),
    padding: EdgeInsets.all(15),
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(bottom: 15),
        decoration: _tileDecoration(),
        child: ListTile(
          leading: Icon(
            Icons.chevron_left,
          ),
          title: Text(
            'تنظیمات',
            textDirection: TextDirection.rtl,
            style: TextStyle(
                fontFamily: "Vazir",
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Colors.black),
          ),
          subtitle: Text(
            ' تنظیمات حساب کاربری',
            textDirection: TextDirection.rtl,
            style: TextStyle(
                fontFamily: "Vazir", fontSize: 11, fontWeight: FontWeight.w300),
          ),
          trailing: SvgPicture.asset(
            settingIcon,
            width: 20,
            height: 20,
            color: Colors.blue,
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<Null>(
                builder: (BuildContext context) {
                  return SettingsPage();
                },
                fullscreenDialog: true,
              ),
            );
          },
        ),
      ),
      Container(
        margin: EdgeInsets.only(bottom: 15),
        decoration: _tileDecoration(),
        child: ListTile(
          leading: Icon(
            Icons.chevron_left,
          ),
          title: Text(
            'خریدهای من',
            textDirection: TextDirection.rtl,
            style: TextStyle(
                fontFamily: "Vazir",
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Colors.black),
          ),
          subtitle: Text(
            'لیست کدهای اسکن شده',
            textDirection: TextDirection.rtl,
            style: TextStyle(
                fontFamily: "Vazir", fontSize: 11, 
                fontWeight: FontWeight.w300),
          ),
          trailing: SvgPicture.asset(
            codeIcon,
            width: 20,
            height: 20,
            color: Colors.blue,
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<Null>(
                builder: (BuildContext context) {
                  return History();
                },
                fullscreenDialog: true,
              ),
            );
          },
        ),
      ),
      Container(
        margin: EdgeInsets.only(bottom: 15),
        decoration: _tileDecoration(),
        child: ListTile(
          leading: Icon(
            Icons.chevron_left,
          ),
          title: Text(
            'درخواست برداشت',
            textDirection: TextDirection.rtl,
            style: TextStyle(
                fontFamily: "Vazir",
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
          subtitle: Text(
            ' واریز موجودی کیف پول به حساب بانکی',
            textDirection: TextDirection.rtl,
            style: TextStyle(
                fontFamily: "Vazir", fontSize: 11, fontWeight: FontWeight.w300),
          ),
          trailing: SvgPicture.asset(
            withdrawIcon,
            width: 20,
            height: 20,
            color: Colors.blue,
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<Null>(
                builder: (BuildContext context) {
                  return History();
                },
                fullscreenDialog: true,
              ),
            );
          },
        ),
      ),
    ],
  );
}

BoxDecoration _tileDecoration() {
  return BoxDecoration(
    color: Colors.white,
    border: Border.all(color: Colors.white, width: 0, style: BorderStyle.solid),
    borderRadius: BorderRadius.all(
      Radius.circular(5.0),
    ),
    boxShadow: [
      BoxShadow(
          color: Colors.grey[200],
          offset: Offset(0, 0),
          blurRadius: 3,
          spreadRadius: 1)
    ],
  );
}
