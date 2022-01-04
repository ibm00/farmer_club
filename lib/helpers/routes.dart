import 'package:farmer_club/presentation/screens/login_screen/login.dart';
import 'package:farmer_club/presentation/screens/register_screen/register_screen.dart';
import 'package:flutter/material.dart';

import '../presentation/screens/splash_screen/splash_screen.dart';

class RoutesHelper {
  static Map<String, Widget Function(BuildContext)> getRoutes(
      BuildContext ctx) {
    return {
      // '/': (ctx) => SplashScreen(),
      '/': (ctx) => LoginScreen(),
      LoginScreen.routeName: (ctx) => LoginScreen(),
      RegisterScreen.routeName: (ctx) => RegisterScreen(),
    };
  }
}
