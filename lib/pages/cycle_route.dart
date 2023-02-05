import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:async';
import 'dart:convert';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CycleRoute extends StatefulWidget {
  const CycleRoute({Key? key}) : super(key: key);

  @override
  State<CycleRoute> createState() => _CycleRouteState();
}

class _CycleRouteState extends State<CycleRoute> {
  Map data = {};
  String file = '';
  List<List<LatLng>> pointsArray = <List<LatLng>>[];
  String routeNumber = '';
  String routeName = '';
  String routeType = '';
  String distance = '';
  String elevation = '';
  String decent = '';
  String estMovingTime = '';
  String bannerImage = '';
  String difficulty = '';
  String description = '';
  double mapLat = 0;
  double mapLng = 0;
  double mapZoom = 0;
  double finalZoom = 0;
  MapController mapController = MapController();
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      loadJson();
    });
  }

  void loadJson() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedFile = prefs.getString('route');
    file = savedFile!;

    String loadedData = await DefaultAssetBundle.of(context).loadString("assets/json/$file.json");
    final jsonData = jsonDecode(loadedData);

    List<dynamic> geometries = jsonData['geometries'];
    List<List<LatLng>> newPointsArray = <List<LatLng>>[];
    for (dynamic geometry in geometries) {
      List<LatLng> points = <LatLng>[];
      for (List<dynamic> coordinate in geometry['coordinates']) {
        points.add(LatLng(coordinate[1], coordinate[0]));
      }
      newPointsArray.add(points);
    }

    setState(() {
      routeNumber = jsonData['routeNumber'];
      routeName = jsonData['routeName'];
      routeType = jsonData['routeType'];
      distance = jsonData['distance'];
      elevation = jsonData['elevation'];
      decent = jsonData['decent'];
      estMovingTime = jsonData['estMovingTime'];
      bannerImage = jsonData['bannerImage'];
      difficulty = jsonData['difficulty'];
      description = jsonData['description'];
      mapLat = jsonData['mapLat'];
      mapLng = jsonData['mapLng'];
      mapZoom = jsonData['mapZoom'];
      pointsArray = newPointsArray;
      isVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Marker> markers = <Marker>[];
    if (pointsArray.isNotEmpty) {
      mapController.move(LatLng(mapLat, mapLng), mapZoom);
      markers = <Marker>[
        Marker(
          width: 80,
          height: 80,
          point: pointsArray[0][0],
          builder: (ctx) {
            return const DecoratedIcon(
              icon: Icon(Icons.place, color: Colors.red, size: 35),
              decoration: IconDecoration(
                shadows: [Shadow(blurRadius: 5, offset: Offset(5, 0))],
              ),
            );
          }
        ),
        Marker(
          width: 80,
          height: 80,
          point: pointsArray[pointsArray.length-1][pointsArray[pointsArray.length-1].length-1],
          builder: (ctx) {
            return const DecoratedIcon(
              icon: Icon(Icons.flag, color: Colors.red, size: 35),
              decoration: IconDecoration(
                shadows: [Shadow(blurRadius: 5, offset: Offset(5, 0))],
              ),
            );
          }
        ),
      ];
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          width: 1200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 8,),
              Container(
                constraints: const BoxConstraints(
                    maxHeight: 250
                ),
                child: ClipRRect(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
                    child: Visibility(
                      visible: isVisible,
                      child: Hero(
                        tag: routeNumber,
                        child: Image.network(
                          bannerImage,
                          width: 1200,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    )
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
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Home', style: TextStyle(
                              fontFamily: 'Archivo',
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              color: Color(0xFF56A5F4),
                              decoration: TextDecoration.underline,
                            )),
                          ),
                          Text(' -> $routeName', style: const TextStyle(
                            fontFamily: 'Archivo',
                            fontWeight: FontWeight.w700,
                            fontSize: 12
                          )),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SelectableText(routeName, style: const TextStyle(
                        fontFamily: 'Archivo',
                        fontWeight: FontWeight.w700,
                        fontSize: 32
                      )),
                      const SizedBox(height: 16),
                      SelectableText(description, style: const TextStyle(
                          fontFamily: 'Archivo',
                          fontWeight: FontWeight.w400,
                          fontSize: 18
                      )),
                      const SizedBox(height: 16),
                      Visibility(
                        visible: isVisible,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SelectableText('Route Type', style: TextStyle(
                                      fontFamily: 'Archivo',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12
                                  )),
                                  SelectableText(routeType, style: const TextStyle(
                                      fontFamily: 'Archivo',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 28
                                  )),
                                ],
                              ),
                              const SizedBox(width: 32.0),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: const Color(0xFFF5F5F5))
                                ),
                                child: const SizedBox(height: 32.0),
                              ),
                              const SizedBox(width: 32.0),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SelectableText('Distance', style: TextStyle(
                                      fontFamily: 'Archivo',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12
                                  )),
                                  SelectableText(distance, style: const TextStyle(
                                      fontFamily: 'Archivo',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 28
                                  )),
                                ],
                              ),
                              const SizedBox(width: 32.0),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: const Color(0xFFF5F5F5))
                                ),
                                child: const SizedBox(height: 32.0),
                              ),
                              const SizedBox(width: 32.0),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SelectableText('Elevation', style: TextStyle(
                                      fontFamily: 'Archivo',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12
                                  )),
                                  SelectableText(elevation, style: const TextStyle(
                                      fontFamily: 'Archivo',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 28
                                  )),
                                ],
                              ),
                              const SizedBox(width: 32.0),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: const Color(0xFFF5F5F5))
                                ),
                                child: const SizedBox(height: 32.0),
                              ),
                              const SizedBox(width: 32.0),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SelectableText('Est. Moving Time', style: TextStyle(
                                      fontFamily: 'Archivo',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12
                                  )),
                                  SelectableText(estMovingTime, style: const TextStyle(
                                      fontFamily: 'Archivo',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 28
                                  )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0)),
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
                      PolylineLayerOptions(
                        polylines: List.generate(pointsArray.length, (index) {
                          return Polyline(
                              points: pointsArray[index],
                              strokeWidth: 5,
                              color: Colors.blue.shade900,//Color(0xFF0D47A1),
                              borderColor: Colors.white,
                              borderStrokeWidth: 5
                          );
                        }),
                      ),
                      MarkerLayerOptions(markers: markers),
                    ],
                  )
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: routeNumber == '1' ? null : () async {
                        String nextRoute = 'route${int.parse(routeNumber)-1}';
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString('route', nextRoute);
                        if (!mounted) return;
                        Navigator.popAndPushNamed(context, '/route', arguments: {
                          'file': nextRoute,
                        });
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.navigate_before),
                          Text('Previous')
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: routeNumber == '11' ? null : () async {
                        String nextRoute = 'route${int.parse(routeNumber)+1}';
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString('route', nextRoute);
                        if (!mounted) return;
                        Navigator.popAndPushNamed(context, '/route', arguments: {
                          'file': nextRoute,
                        });
                      },
                      child: Row(
                        children: const [
                          Text('Next'),
                          Icon(Icons.navigate_next),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // const SizedBox(height: 500,),
            ],
          ),
        ),
      ),
    );
  }
}
