import 'package:explorer/settings/settings_page.dart';
import 'package:explorer/settings/wallet_page.dart';
import 'package:explorer/splash.dart';
import 'package:flutter/material.dart';
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.only(left: 16.0, right: 16.0, top: kToolbarHeight),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  maxRadius: 48,
                  // backgroundImage: AssetImage('assets/background.jpg'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'بهزاد فرید اقدم',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8)),
                      color: yellow,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4,
                            spreadRadius: 1,
                            offset: Offset(0, 1))
                      ]),
                  height: 100,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.money_off, color: darkBlue),
                              color: darkBlue,
                              onPressed: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => WalletPage()))
                            ),
                            Text(
                              'کیف پول',
                              style: TextStyle(fontSize: 12, fontFamily: 'Vazir', fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.payment, color: darkBlue),
                              onPressed: () => {},
                            ),
                            Text(
                              'پرداخت ها',
                              style: TextStyle(fontSize: 12,fontFamily: 'Vazir',fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.help, color: darkBlue),
                              onPressed: () {},
                            ),
                            Text(
                              'پشتیبانی',
                              style: TextStyle(fontSize: 12,fontFamily: 'Vazir',fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  title: Text('تنظیمات',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: 'Vazir',
                        fontSize: 12,
                      )),
                  subtitle: Text('تنظیمات امنیتی و خروج از حساب کاربری',
                  textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: 'Vazir',
                        fontSize: 10,
                      )),
                  trailing: Icon(Icons.settings),
                  leading: Icon(Icons.chevron_left, color: Colors.yellow),
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => SettingsPage())),
                ),
                Divider(),
                ListTile(
                  title: Text('پشتیبانی',
                  textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: 'Vazir',
                        fontSize: 12,
                      )),
                  subtitle: Text(
                    'مرکز پشتیبانی و آموزش',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontFamily: 'Vazir',
                      fontSize: 10,
                    ),
                  ),
                  trailing: Icon(Icons.help),
                  leading: Icon(
                    Icons.chevron_left,
                    color: Colors.yellow,
                  ),
                  onTap: () {},
                ),
                Divider(),
                ListTile(
                  title: Text('سوالات رایج',
                  textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: 'Vazir',
                        fontSize: 12,
                      )),
                  subtitle: Text('پاسخ به سوالات رایج',
                  textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: 'Vazir',
                        fontSize: 10,
                      )),
                  trailing: Icon(Icons.question_answer),
                  leading: Icon(Icons.chevron_left, color: Colors.yellow),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
