import 'package:explorer/gift_list.dart';
import 'package:explorer/home.dart';
import 'package:explorer/loplob_page.dart';
import 'package:explorer/map_page.dart';
import 'package:explorer/profile.dart';
import 'package:explorer/scan_result.dart';
import 'package:explorer/splash.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'settings/settings_page.dart';
import 'package:flutter_svg/svg.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  PageController _pageController;
  final String giftIcon = 'images/gifts.svg';
  final String homeIcon = 'images/home.svg';
  final String personIcon = 'images/person.svg';
  final String diamondIcon = 'images/diamond.svg';

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
    _pageController = PageController();
  }

  Future _scan() async {
    String barcode = await scanner.scan();
    Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => ScanResult(message: "message")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: currentIndex,
          children: <Widget>[
            Home(),
            LoplobPage(),
            GiftList(),
            MapPage(),
            Profile()
          ],
        ),
      ),
      backgroundColor: Colors.white,
      floatingActionButton: Container(
          height: 60.0,
          width: 60.0,
          child: FloatingActionButton(
            elevation: 15,
            backgroundColor: Colors.white,
            child: const Icon(
              Icons.camera_alt,
              color: Colors.black,
              size: 34,
            ),
            onPressed: _scan,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor: Colors.white,
            primaryColor: yellow,
            // sets the active color of the `BottomNavigationBar` if `Brightness` is light
            textTheme: Theme.of(context).textTheme.copyWith(
                caption: new TextStyle(
                    color: Colors
                        .black))), // sets the inactive color of the `BottomNavigationBar`
        child: new BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
          items: [
            new BottomNavigationBarItem(
              icon: SvgPicture.asset(
                homeIcon,
                width: 20,
                height: 20,
                color: Colors.black,
              ),
              activeIcon: SvgPicture.asset(
                homeIcon,
                width: 20,
                height: 20,
                color: yellow,
              ),
              title: Padding(padding: EdgeInsets.all(0)),
            ),
            new BottomNavigationBarItem(
              icon: SvgPicture.asset(
                giftIcon,
                width: 24,
                height: 24,
                color: Colors.black,
              ),
              activeIcon: SvgPicture.asset(
                giftIcon,
                width: 24,
                height: 24,
                color: yellow,
              ),
              title: Padding(padding: EdgeInsets.all(0)),
            ),
            new BottomNavigationBarItem(
              icon: Padding(padding: EdgeInsets.all(0)),
              title: Padding(padding: EdgeInsets.all(0)),
            ),
            new BottomNavigationBarItem(
              icon: SvgPicture.asset(
                diamondIcon,
                width: 24,
                height: 24,
                color: Colors.black,
              ),
              activeIcon: SvgPicture.asset(
                diamondIcon,
                width: 24,
                height: 24,
                color: yellow,
              ),
              title: Padding(padding: EdgeInsets.all(0)),
            ),
            new BottomNavigationBarItem(
              icon: SvgPicture.asset(
                personIcon,
                width: 24,
                height: 24,
                color: Colors.black,
              ),
              activeIcon: SvgPicture.asset(
                personIcon,
                width: 24,
                height: 24,
                color: yellow,
              ),
              title: Padding(padding: EdgeInsets.all(0)),
            )
          ],
        ),
      ),
    );
  }
}
