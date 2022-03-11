import 'package:flutter/material.dart';
import '../../screens/comments_screen.dart/comments_screen.dart';
import '../../screens/home_screen/home_screen.dart';
import '../../screens/login_screen/login_screen.dart';
import '../../screens/register_screen/register_screen.dart';
import '../../screens/root_screen/root_screen.dart';
import '../../screens/splash_screen/splash_screen.dart';

class RoutesHelper {
  static Route generateRoute(RouteSettings settings) {
    final routeArgs = settings.arguments;
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
      case CommentsScreen.routeName:
        final postId = routeArgs as String;
        return MaterialPageRoute(
          builder: (context) => CommentsScreen(postId: postId),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
        );
    }
  }
}
