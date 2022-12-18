import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:japan_cycling/pages/landing.dart';
import 'package:japan_cycling/pages/cycle_route.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() => runApp(MaterialApp(
  builder: (context, child) => ResponsiveWrapper.builder(
    child,
    maxWidth: 1200,
    minWidth: 480,
    defaultScale: true,
    breakpoints: [
      const ResponsiveBreakpoint.resize(480, name: MOBILE),
      const ResponsiveBreakpoint.autoScale(800, name: TABLET),
      const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
    ],
    // background: Container(color: const Color(0xFFF5F5F5))),
    background: Container(color: Colors.white)),
  scrollBehavior: const MaterialScrollBehavior().copyWith(dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch,}),
  initialRoute: '/',
  onGenerateRoute: (settings) {

  },
  routes: {
    '/': (context) => const Landing(),
    '/route': (context) => const CycleRoute(),
  },
));
