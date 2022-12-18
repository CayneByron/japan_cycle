import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  State<Landing> createState() => _LandingState();
}



class _LandingState extends State<Landing> {

  void openRoutePage(String route) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('route', route);
    if (!mounted) return;
    Navigator.pushNamed(context, '/route', arguments: {
      'file': route,
    });
  }

  @override
  Widget build(BuildContext context) {
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
