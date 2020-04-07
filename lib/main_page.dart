import 'package:explorer/home.dart';
import 'package:explorer/scan_result.dart';
import 'package:explorer/splash.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'settings/settings_page.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  PageController _pageController;

  
  @override
  void initState() {
    super.initState();
    currentIndex = 0;
    _pageController = PageController();
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });

    _pageController.jumpToPage(index);
  }


  Future _scan() async {
    String barcode = await scanner.scan();
    Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => ScanResult(message: "message")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => currentIndex = index);
            },
            children: <Widget>[
              Home(),
              SettingsPage()
            ],
          ),
        ),
        backgroundColor: Colors.white,
        floatingActionButton: Container(
            height: 70.0,
            width: 70.0,
            child: FloatingActionButton(
              elevation: 15,
              backgroundColor: Colors.grey[200],
              child: const Icon(
                Icons.camera_alt,
                color: Colors.black,
                size: 40,
              ),
              onPressed: _scan,
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Container(
          height: 60,
          // decoration: BoxDecoration(
          //   border: Border(
          //     top: BorderSide(width: 1.0, color: Colors.grey),
          //   )
          // ),
          child: BottomAppBar(
            // shape: CircularNotchedRectangle(),
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.home),
                  color: darkBlue,
                  onPressed: () {
                    _pageController.jumpToPage(0);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.settings),
                  color: darkBlue,
                  onPressed: () {
                    _pageController.jumpToPage(1);
                  },
                ),
              ],
            ),
            color: yellow,
          ),
        ));
  }
}
