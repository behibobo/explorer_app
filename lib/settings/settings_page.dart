import 'package:explorer/models/user.dart';
import 'package:explorer/settings/edit_profile.dart';
import 'package:explorer/splash.dart';
import 'package:flutter/material.dart';
import 'package:explorer/providers/auth.dart';

class SettingsPage extends StatelessWidget {
  Future<User> _getProfile() async {
    AuthProvider prov = new AuthProvider();
    return await prov.profile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text(
            "حساب کاربری",
            style: TextStyle(color: Colors.black,
            fontFamily: "Vazir", fontSize: 12, fontWeight: FontWeight.bold),
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
        body: SafeArea(
            bottom: true,
            child: LayoutBuilder(
                builder: (builder, constraints) => SingleChildScrollView(
                    child: ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: constraints.maxHeight),
                        child: Padding(
                            padding: const EdgeInsets.only(
                                top: 24.0, left: 24.0, right: 24.0),
                            child: FutureBuilder<User>(
                                future: _getProfile(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<User> snapshot) {
                                  if (snapshot.hasData) {
                                    return _itemBuilder(context, snapshot.data);
                                  } else {
                                    return Center(
                                    child: SizedBox(
                                      child: CircularProgressIndicator(),
                                      width: 60,
                                      height: 60,
                                    ));
                                  }
                                })))))));
  }

  Widget _itemBuilder(context, User entry) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 15),
          child: Text(
            'تنظیمات کلی',
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            style: TextStyle(
                color: darkBlue,
                fontFamily: 'Vazir',
                fontWeight: FontWeight.bold,
                fontSize: 14.0),
          ),
        ),
        ListTile(
          title: Text('اگاهسازی',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                  fontSize: 12, fontFamily: 'Vazir', color: darkBlue)),
          leading: Icon(Icons.notifications, color: darkBlue),
          onTap: () {},
        ),
        ListTile(
          title: Text('درباره ما',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 12,
                color: darkBlue,
                fontFamily: 'Vazir',
              )),
          leading: Icon(Icons.people, color: darkBlue),
          onTap: () {},
        ),
        Divider(
          thickness: 1,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 15),
          child: Text(
            'حساب کاربری',
            textDirection: TextDirection.rtl,
            style: TextStyle(
                color: darkBlue,
                fontWeight: FontWeight.bold,
                fontFamily: 'Vazir',
                fontSize: 14.0),
          ),
        ),
        ListTile(
          title: Text('ویرایش اطلاعات کاربری',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                  fontSize: 12, fontFamily: 'Vazir', color: darkBlue)),
          leading: Icon(Icons.person, color: darkBlue),
          onTap: () {
            Navigator.of(context).push(
                    MaterialPageRoute<Null>(
                      builder: (BuildContext context) {
                        return EditProfile(entry);
                      },
                      fullscreenDialog: true,
                    ),
                  );
          },
        ),
        ListTile(
          title: Text(
            'خروج از حساب کاربری',
            textDirection: TextDirection.rtl,
            style:
                TextStyle(fontSize: 12, fontFamily: 'Vazir', color: darkBlue),
          ),
          leading: Icon(Icons.exit_to_app, color: darkBlue),
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => Splash())),
        ),
        Divider(
          thickness: 1,
        )
      ],
    );
  }
}
