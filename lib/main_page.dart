import 'package:explorer/all_loplobs.dart';
import 'package:explorer/gift_list.dart';
import 'package:explorer/history.dart';
import 'package:explorer/home.dart';
import 'package:explorer/loplob_page.dart';
import 'package:explorer/map_page.dart';
import 'package:explorer/models/treasure.dart';
import 'package:explorer/profile.dart';
import 'package:explorer/providers/item.dart';
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
  final String giftIcon = 'images/gifts.svg';
  final String homeIcon = 'images/home.svg';
  final String personIcon = 'images/person.svg';
  final String diamondIcon = 'images/diamond.svg';
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  Future _scan() async {
    String barcode = await scanner.scan();
    ItemProvider prov = new ItemProvider();
    Map res = await prov.scanItem(barcode);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => ScanResult(res)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              switch (index) {
                case 0:
                  _navigatorKey.currentState.pushReplacementNamed("home");
                  break;
                case 1:
                  _navigatorKey.currentState.pushReplacementNamed("loplobs");
                  break;
                case 3:
                  _navigatorKey.currentState.pushReplacementNamed("treasures");
                  break;
                case 4:
                  _navigatorKey.currentState.pushReplacementNamed("profile");
                  break;
              }

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
        body: Navigator(key: _navigatorKey, onGenerateRoute: generateRoute));
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "home":
        return MaterialPageRoute(builder: (_) => Home());
      case "loplobs":
        return MaterialPageRoute(builder: (_) => AllLoplobs());
      case "treasures":
        return MaterialPageRoute(builder: (_) => MapPage());
      case "profile":
        return MaterialPageRoute(builder: (_) => Profile());
      default:
        return MaterialPageRoute(builder: (_) => Home());
    }
  }
}
