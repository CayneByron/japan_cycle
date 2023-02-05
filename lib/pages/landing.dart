import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:flutter/services.dart';
import 'package:japan_cycling/models/last_known_location.dart';
import 'package:japan_cycling/providers/LastLocationProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:async';
import 'dart:convert';
import 'package:icon_decoration/icon_decoration.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  State<Landing> createState() => _LandingState();

}



class _LandingState extends State<Landing> {
  double mapLat = 36.452571;
  double mapLng = 136.510094;
  LatLng point = LatLng(36.452571, 136.510094);
  double mapZoom = 10.0;
  double finalZoom = 10.0;
  MapController mapController = MapController();
  // List<List<LatLng>> pointsArray = <List<LatLng>>[];
  List<Marker> markers = <Marker>[];
  bool popupShown = false;

  void openRoutePage(String route) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('route', route);
    if (!mounted) return;
    Navigator.pushNamed(context, '/route', arguments: {
      'file': route,
    });
  }

  @override
  void initState () {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _asyncMethod();
    });

  }

  _asyncMethod() async {
    LastKnownLocation lkl = await LastLocationProvider.getRecords();
    setState(() {
      mapLat = lkl.latitude;
      mapLng = lkl.longitude;
      point = LatLng(lkl.latitude, lkl.longitude);
      mapController.move(point, 10.0);
    });

  }

  @override
  Widget build(BuildContext context) {
    MouseRegion popupContainer = MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
            setState(() {
              popupShown = false;
            });
        }, // remove the popup if we click on it
        child: Card(
          elevation: 20.0,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              ListTile(
                leading: const MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Icon(Icons.directions_bike_sharp,
                      color: Colors.pink,
                    )
                ),
                title: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Text('$mapLat, $mapLng'),
                ),
                subtitle: const MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Text('Sun, 05 Feb 2023 00:40:25')
                ),
              ),
            ],
          ),
        ),
      ),
    );

    markers = <Marker>[
      Marker(
          width: 80,
          height: 80,
          point: point,
          builder: (ctx) {
            return MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () async {
                  setState(() {
                    popupShown = !popupShown;
                  });
                },
                child: const DecoratedIcon(
                  icon: Icon(Icons.directions_bike_outlined, color: Colors.pink, size: 35),
                  decoration: IconDecoration(
                    shadows: [Shadow(blurRadius: 5, offset: Offset(5, 0))],
                  ),
                ),
              ),
            );
          }
      ),
    ];

    if (popupShown == true) {
      markers.add(
          Marker(
            width: 300.0,
            height: 75.0,
            point: point, // Probably want to add an offset so it appears above the point, rather than over it
            builder: (ctx) => popupContainer,
          )
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      constraints: const BoxConstraints(
                          maxHeight: 300
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          'https://res.cloudinary.com/di12po0kz/image/upload/v1663358312/pexels-tom%C3%A1%C5%A1-mal%C3%ADk-3408354_oeog8l.jpg',
                          width: 1200,
                          fit: BoxFit.fitWidth,
                          // alignment: Alignment.centerLeft,
                        )
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(32.0),
                      child: SelectableText(
                        '700km Cycle Across Japan 2023',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Archivo',
                          fontWeight: FontWeight.w700,
                          fontSize: 36,
                          color: Colors.white
                        )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: SelectableText(
                        '700km Cycle Across Japan 2023',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Archivo',
                          fontWeight: FontWeight.w700,
                          fontSize: 36,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 1
                            ..color = Colors.red,
                        )
                      ),
                    ),
                  ]
                ),
                SizedBox(
                  width: 1200,
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SelectableText('Cycle Route Across Japan', style: TextStyle(
                          fontFamily: 'Archivo',
                          fontWeight: FontWeight.w700,
                          fontSize: 24
                        )),
                        const SizedBox(height: 32),
                        const SelectableText('Leg 1', style: TextStyle(
                            fontFamily: 'Archivo',
                            fontWeight: FontWeight.w400,
                            fontSize: 18
                        )),
                        const SizedBox(height: 8),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  openRoutePage('route1');
                                },
                                child: Card(
                                  elevation: 8.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                              borderRadius: BorderRadius.circular(4.0),
                                              child: Hero(
                                                tag: 'route1',
                                                child: Image.asset('assets/images/natadera.jpg',
                                                  height: 125,
                                                  width: 200,
                                                  fit: BoxFit.fill,
                                                ),
                                              )
                                          ),
                                          const SizedBox(height: 4),
                                          SizedBox(
                                            width: 200,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.all(2.0),
                                                  child: SelectableText('Route 1', style: TextStyle(
                                                      fontFamily: 'Archivo',
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 12
                                                  )),
                                                ),
                                                Badge(
                                                  toAnimate: false,
                                                  shape: BadgeShape.square,
                                                  badgeColor: Colors.red,
                                                  borderRadius: BorderRadius.circular(6),
                                                  badgeContent: const SelectableText('Intermediate', style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 8,
                                                  )),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(2.0),
                                            child: SelectableText('Kanazawa to Kaga', style: TextStyle(
                                              fontFamily: 'Archivo',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                            )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  openRoutePage('route2');
                                },
                                child: Card(
                                  elevation: 8.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                              borderRadius: BorderRadius.circular(4.0),
                                              child: Hero(
                                                tag: 'route2',
                                                child: Image.asset('assets/images/maruoka.jpg',
                                                  height: 125,
                                                  width: 200,
                                                  fit: BoxFit.fill,
                                                ),
                                              )
                                          ),
                                          const SizedBox(height: 4),
                                          SizedBox(
                                            width: 200,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.all(2.0),
                                                  child: SelectableText('Route 2', style: TextStyle(
                                                      fontFamily: 'Archivo',
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 12
                                                  )),
                                                ),
                                                Badge(
                                                  toAnimate: false,
                                                  shape: BadgeShape.square,
                                                  badgeColor: Colors.red,
                                                  borderRadius: BorderRadius.circular(6),
                                                  badgeContent: const SelectableText('Intermediate', style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 8,
                                                  )),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(2.0),
                                            child: SelectableText('Kaga to Echizen', style: TextStyle(
                                                fontFamily: 'Archivo',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                            )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  openRoutePage('route3');
                                },
                                child: Card(
                                  elevation: 8.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                              borderRadius: BorderRadius.circular(4.0),
                                              child: Hero(
                                                tag: 'route3',
                                                child: Image.network(
                                                  'https://res.cloudinary.com/di12po0kz/image/upload/v1663206626/Port_of_Tsuruga_zwhsug.jpg',
                                                  height: 125,
                                                  width: 200,
                                                  fit: BoxFit.fill,
                                                ),
                                              )
                                          ),
                                          const SizedBox(height: 4),
                                          SizedBox(
                                            width: 200,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.all(2.0),
                                                  child: SelectableText('Route 3', style: TextStyle(
                                                      fontFamily: 'Archivo',
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 12
                                                  )),
                                                ),
                                                Badge(
                                                  toAnimate: false,
                                                  shape: BadgeShape.square,
                                                  badgeColor: Colors.black,
                                                  borderRadius: BorderRadius.circular(6),
                                                  badgeContent: const SelectableText('Difficult', style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 8,
                                                  )),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(2.0),
                                            child: SelectableText('Echizen to Lake Biwa', style: TextStyle(
                                              fontFamily: 'Archivo',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                            )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  openRoutePage('route4');
                                },
                                child: Card(
                                  elevation: 8.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                              borderRadius: BorderRadius.circular(4.0),
                                              child: Hero(
                                                tag: 'route4',
                                                child: Image.network(
                                                  'https://res.cloudinary.com/di12po0kz/image/upload/v1663211466/licensed-image_lg6yft.jpg',
                                                  height: 125,
                                                  width: 200,
                                                  fit: BoxFit.fill,
                                                ),
                                              )
                                          ),
                                          const SizedBox(height: 4),
                                          SizedBox(
                                            width: 200,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.all(2.0),
                                                  child: SelectableText('Route 4', style: TextStyle(
                                                      fontFamily: 'Archivo',
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 12
                                                  )),
                                                ),
                                                Badge(
                                                  toAnimate: false,
                                                  shape: BadgeShape.square,
                                                  badgeColor: Colors.red,
                                                  borderRadius: BorderRadius.circular(6),
                                                  badgeContent: const SelectableText('Intermediate', style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 8,
                                                  )),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(2.0),
                                            child: SelectableText('Lake Biwa to Kyoto', style: TextStyle(
                                              fontFamily: 'Archivo',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                            )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        const SelectableText('Leg 2', style: TextStyle(
                            fontFamily: 'Archivo',
                            fontWeight: FontWeight.w400,
                            fontSize: 18
                        )),
                        const SizedBox(height: 8),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  openRoutePage('route5');
                                },
                                child: Card(
                                  elevation: 8.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                              borderRadius: BorderRadius.circular(4.0),
                                              child: Hero(
                                                tag: 'route5',
                                                child: Image.network(
                                                  'https://res.cloudinary.com/di12po0kz/image/upload/v1663214034/Osaka_Castle_Nishinomaru_Garden_April_2005_gwuaef.jpg',
                                                  height: 125,
                                                  width: 200,
                                                  fit: BoxFit.fill,
                                                ),
                                              )
                                          ),
                                          const SizedBox(height: 4),
                                          SizedBox(
                                            width: 200,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.all(2.0),
                                                  child: SelectableText('Route 5', style: TextStyle(
                                                      fontFamily: 'Archivo',
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 12
                                                  )),
                                                ),
                                                Badge(
                                                  toAnimate: false,
                                                  shape: BadgeShape.square,
                                                  badgeColor: Colors.green,
                                                  borderRadius: BorderRadius.circular(6),
                                                  badgeContent: const SelectableText('Easy', style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 8,
                                                  )),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(2.0),
                                            child: SelectableText('Kyoto to Osaka', style: TextStyle(
                                              fontFamily: 'Archivo',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                            )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  openRoutePage('route6');
                                },
                                child: Card(
                                  elevation: 8.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                              borderRadius: BorderRadius.circular(4.0),
                                              child: Hero(
                                                tag: 'route6',
                                                child: Image.network(
                                                  'https://res.cloudinary.com/di12po0kz/image/upload/v1663215994/Kobe_yswhwr.jpg',
                                                  height: 125,
                                                  width: 200,
                                                  fit: BoxFit.fill,
                                                ),
                                              )
                                          ),
                                          const SizedBox(height: 4),
                                          SizedBox(
                                            width: 200,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.all(2.0),
                                                  child: SelectableText('Route 6', style: TextStyle(
                                                      fontFamily: 'Archivo',
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 12
                                                  )),
                                                ),
                                                Badge(
                                                  toAnimate: false,
                                                  shape: BadgeShape.square,
                                                  badgeColor: Colors.red,
                                                  borderRadius: BorderRadius.circular(6),
                                                  badgeContent: const SelectableText('Intermediate', style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 8,
                                                  )),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(2.0),
                                            child: SelectableText('Osaka to Akashi', style: TextStyle(
                                              fontFamily: 'Archivo',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                            )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  openRoutePage('route7');
                                },
                                child: Card(
                                  elevation: 8.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                              borderRadius: BorderRadius.circular(4.0),
                                              child: Hero(
                                                tag: 'route7',
                                                child: Image.network(
                                                  'https://res.cloudinary.com/di12po0kz/image/upload/v1663217413/1920px-090411_Himeji_Castle_Hyogo_pref_Japan01s10_pypox8.jpg',
                                                  height: 125,
                                                  width: 200,
                                                  fit: BoxFit.fill,
                                                ),
                                              )
                                          ),
                                          const SizedBox(height: 4),
                                          SizedBox(
                                            width: 200,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.all(2.0),
                                                  child: SelectableText('Route 7', style: TextStyle(
                                                      fontFamily: 'Archivo',
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 12
                                                  )),
                                                ),
                                                Badge(
                                                  toAnimate: false,
                                                  shape: BadgeShape.square,
                                                  badgeColor: Colors.green,
                                                  borderRadius: BorderRadius.circular(6),
                                                  badgeContent: const SelectableText('Easy', style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 8,
                                                  )),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(2.0),
                                            child: SelectableText('Akashi to Himeji', style: TextStyle(
                                              fontFamily: 'Archivo',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                            )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  openRoutePage('route8');
                                },
                                child: Card(
                                  elevation: 8.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                              borderRadius: BorderRadius.circular(4.0),
                                              child: Hero(
                                                tag: 'route8',
                                                child: Image.network(
                                                  'https://res.cloudinary.com/di12po0kz/image/upload/v1663265671/1920px-Angel_Road_Shodo_Island_Japan01s3_sai5zk.jpg',
                                                  height: 125,
                                                  width: 200,
                                                  fit: BoxFit.fill,
                                                ),
                                              )
                                          ),
                                          const SizedBox(height: 4),
                                          SizedBox(
                                            width: 200,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.all(2.0),
                                                  child: SelectableText('Route 8', style: TextStyle(
                                                      fontFamily: 'Archivo',
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 12
                                                  )),
                                                ),
                                                Badge(
                                                  toAnimate: false,
                                                  shape: BadgeShape.square,
                                                  badgeColor: Colors.red,
                                                  borderRadius: BorderRadius.circular(6),
                                                  badgeContent: const SelectableText('Intermediate', style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 8,
                                                  )),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(2.0),
                                            child: SelectableText('Himeji to Kurashiki', style: TextStyle(
                                              fontFamily: 'Archivo',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                            )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  openRoutePage('route9');
                                },
                                child: Card(
                                  elevation: 8.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                              borderRadius: BorderRadius.circular(4.0),
                                              child: Hero(
                                                tag: 'route9',
                                                child: Image.network(
                                                  'https://res.cloudinary.com/di12po0kz/image/upload/v1663271211/licensed-image_1_giyfch.jpg',
                                                  height: 125,
                                                  width: 200,
                                                  fit: BoxFit.fill,
                                                ),
                                              )
                                          ),
                                          const SizedBox(height: 4),
                                          SizedBox(
                                            width: 200,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.all(2.0),
                                                  child: SelectableText('Route 9', style: TextStyle(
                                                      fontFamily: 'Archivo',
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 12
                                                  )),
                                                ),
                                                Badge(
                                                  toAnimate: false,
                                                  shape: BadgeShape.square,
                                                  badgeColor: Colors.red,
                                                  borderRadius: BorderRadius.circular(6),
                                                  badgeContent: const SelectableText('Intermediate', style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 8,
                                                  )),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(2.0),
                                            child: SelectableText('Kurashiki to Onomichi', style: TextStyle(
                                              fontFamily: 'Archivo',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                            )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        const SelectableText('Leg 3', style: TextStyle(
                            fontFamily: 'Archivo',
                            fontWeight: FontWeight.w400,
                            fontSize: 18
                        )),
                        const SizedBox(height: 8),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  openRoutePage('route10');
                                },
                                child: Card(
                                  elevation: 8.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                              borderRadius: BorderRadius.circular(4.0),
                                              child: Hero(
                                                tag: 'route10',
                                                child: Image.network(
                                                  'https://res.cloudinary.com/di12po0kz/image/upload/v1663272307/3478_02_xrtbkg.jpg',
                                                  height: 125,
                                                  width: 200,
                                                  fit: BoxFit.fill,
                                                ),
                                              )
                                          ),
                                          const SizedBox(height: 4),
                                          SizedBox(
                                            width: 200,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.all(2.0),
                                                  child: SelectableText('Route 10', style: TextStyle(
                                                      fontFamily: 'Archivo',
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 12
                                                  )),
                                                ),
                                                Badge(
                                                  toAnimate: false,
                                                  shape: BadgeShape.square,
                                                  badgeColor: Colors.black,
                                                  borderRadius: BorderRadius.circular(6),
                                                  badgeContent: const SelectableText('Difficult', style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 8,
                                                  )),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(2.0),
                                            child: SelectableText('Onomichi to Imabari', style: TextStyle(
                                              fontFamily: 'Archivo',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                            )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  openRoutePage('route11');
                                },
                                child: Card(
                                  elevation: 8.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                              borderRadius: BorderRadius.circular(4.0),
                                              child: Hero(
                                                tag: 'route11',
                                                child: Image.network(
                                                  'https://res.cloudinary.com/di12po0kz/image/upload/v1663273527/dogo-onsen-matsuyama-ehime-iStock-458413495-1280x600_mwkhzb.jpg',
                                                  height: 125,
                                                  width: 200,
                                                  fit: BoxFit.fill,
                                                ),
                                              )
                                          ),
                                          const SizedBox(height: 4),
                                          SizedBox(
                                            width: 200,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.all(2.0),
                                                  child: SelectableText('Route 11', style: TextStyle(
                                                      fontFamily: 'Archivo',
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 12
                                                  )),
                                                ),
                                                Badge(
                                                  toAnimate: false,
                                                  shape: BadgeShape.square,
                                                  badgeColor: Colors.green,
                                                  borderRadius: BorderRadius.circular(6),
                                                  badgeContent: const SelectableText('Easy', style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 8,
                                                  )),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(2.0),
                                            child: SelectableText('Imabari to Hiroshima', style: TextStyle(
                                              fontFamily: 'Archivo',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                            )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  width: 1200,
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SelectableText('Last Known Location', style: TextStyle(
                              fontFamily: 'Archivo',
                              fontWeight: FontWeight.w700,
                              fontSize: 24
                          )),
                        ),
                        ClipRRect(
                          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0), topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
                          child: SizedBox(
                              width: 1200,
                              height: 500,
                              child: FlutterMap(
                                mapController: mapController,
                                options: MapOptions(
                                  center: LatLng(mapLat, mapLng),
                                  zoom: finalZoom,
                                ),
                                layers: [
                                  TileLayerOptions(
                                    urlTemplate:
                                    'https://tile.thunderforest.com/cycle/{z}/{x}/{y}.png?apikey=ed4d648a198c4a5184877c68c3271e70',
                                    subdomains: ['a', 'b', 'c'],
                                    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                                  ),
                                  MarkerLayerOptions(markers: markers),
                                ],
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 300),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
