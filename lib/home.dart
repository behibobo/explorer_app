import 'package:explorer/gift_list.dart';
import 'package:explorer/history.dart';
import 'package:explorer/models/item.dart';
import 'package:explorer/models/treasure.dart';
import 'package:explorer/models/user.dart';
import 'package:explorer/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:explorer/providers/auth.dart';
import 'package:explorer/styles/main.dart';
import 'package:flutter_svg/svg.dart';

final String diamondIcon = 'images/diamond.svg';
final String giftIcon = 'images/gifts.svg';
final String winnerIcon = 'images/winner.svg';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  Future<User> _getProfile() async {
    return await Provider.of<AuthProvider>(context).profile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppbar(context, "کاوشگر"),
      body: SingleChildScrollView(
        child: 
        Container(
          height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.1), BlendMode.dstATop),
            image: AssetImage('images/map.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder<User>(
      future: _getProfile(),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        List<Widget> children;

        if (snapshot.hasData) {
          children = <Widget>[
            content(context, snapshot.data),
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
    ))));
  }
}

Widget content(BuildContext context, User entry) {
  return SafeArea(
    child: Container(
          color: Colors.white10,
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              
              SizedBox(height: 20,),
              Container(
                height: 210,
                child: ListView(
                  shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => GiftList()));
                      },
                    child: SpecialistTile(
                        imgAssetPath: giftIcon,
                        details: "تعداد جوایز پنهان در محصولات",
                        noOf: 100,
                        backColor: yellow,
                      )),
                      GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => TreasureList()));
                      },
                    child: SpecialistTile(
                        imgAssetPath: diamondIcon,
                        details: "گنج های پنهان در شهر",
                        noOf: 40,
                        backColor: Colors.blue,
                      )),GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => TreasureList()));
                      },
                    child: SpecialistTile(
                        imgAssetPath: winnerIcon,
                        details: "جوایز کشف شده",
                        noOf: 12,
                        backColor: Color(0xffF69383),
                      ))
                  ],
                    
                      
                    ),
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      );
  
}

class SpecialistTile extends StatelessWidget {

  final String imgAssetPath;
  final String details;
  final int noOf;
  final Color backColor;
  SpecialistTile({@required this.imgAssetPath,@required this.details
    ,@required this.noOf, @required this.backColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: backColor,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: EdgeInsets.only(top: 16,right: 16,left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(details, 
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: "Vazir",
            fontSize: 12
          ),),
          SizedBox(height: 6,),
          Text(noOf.toString(), 
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: "Vazir",
            fontSize: 12
          ),),
          Center(
            child: SvgPicture.asset(
                imgAssetPath,
                height: 80,
                color: Colors.white,
                
              ))
        ],
      ),
    );
  }
}