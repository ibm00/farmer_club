import 'package:flutter/material.dart';

import '../presentation/screens/splash_screen/splash_screen.dart';

class RoutesHelper {
  static Map<String, Widget Function(BuildContext)> getRoutes(
      BuildContext ctx) {
    return {
      // '/': (ctx) => MyHomePage(),
      '/': (ctx) => SplashScreen(),
    };
  }
}
