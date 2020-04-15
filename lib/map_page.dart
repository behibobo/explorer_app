import 'dart:developer';

import 'package:explorer/models/treasure.dart';
import 'package:explorer/widgets/appbar.dart';
import 'package:explorer/styles/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_svg/svg.dart';
import 'package:explorer/providers/item.dart';

class MapPage extends StatefulWidget {
  MapPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final LatLng _center = LatLng(38.079188, 46.289197);
  final String diamondIcon = 'images/diamond.svg';
  List<Treasure> items = [];
  @override
  void initState() {
    super.initState();
  }

  Future<List<Treasure>> _getTreasures() async {
    ItemProvider prov = new ItemProvider();
    return await prov.getTreasures();
  }

  @override
  Widget build(BuildContext context) {
    log(items.length.toString());
    var markers = <Marker>[];

    return FutureBuilder(
      future: _getTreasures(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          for (Treasure item in snapshot.data) {
            markers.add(Marker(
              width: 20.0,
              height: 20.0,
              point: LatLng(double.parse(item.lat), double.parse(item.lng)),
              builder: (ctx) => Container(
                child: SvgPicture.asset(
                  diamondIcon,
                  width: 10,
                  height: 10,
                  color: Colors.black,
                ),
              ),
            ));
          }
          
          return Scaffold(
            appBar: mainAppbar(context, "کاوشگر"),
            body: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Flexible(
                    child: FlutterMap(
                      options: MapOptions(
                        center: _center,
                        zoom: 13.0,
                      ),
                      layers: [
                        TileLayerOptions(
                          urlTemplate:
                              'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                          subdomains: ['a', 'b', 'c'],
                          // For example purposes. It is recommended to use
                          // TileProvider with a caching and retry strategy, like
                          // NetworkTileProvider or CachedNetworkTileProvider
                          tileProvider: NonCachingNetworkTileProvider(),
                        ),
                        MarkerLayerOptions(markers: markers)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          SizedBox(
            child: CircularProgressIndicator(),
            width: 60,
            height: 60,
          );
        }
      },
    );
  }
}
