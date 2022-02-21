import 'package:flutter/material.dart';
import '../../screens/home_screen/home_screen.dart';
import '../../screens/login_screen/login_screen.dart';
import '../../screens/register_screen/register_screen.dart';
import '../../screens/roote_screen/roote_screen.dart';
import '../../screens/splash_screen/splash_screen.dart';

class RoutesHelper {
  // static Map<String, Widget Function(BuildContext)> getRoutes(
  //     BuildContext ctx) {
  //   return {
  //     // '/': (ctx) => SplashScreen(),
  //     '/': (ctx) => LoginScreen(),
  //     LoginScreen.routeName: (ctx) => LoginScreen(),
  //     RegisterScreen.routeName: (ctx) => RegisterScreen(),
  //   };
  // }

  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => LoginScreen(),
        );
      case HomeScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case SplashScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
        );
      case RooteScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const RooteScreen(),
        );
      case RegisterScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => RegisterScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
        );
    }
  }
}
