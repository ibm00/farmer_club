import 'package:farmer_club/screens/error_screen/error_screen.dart';
import 'package:farmer_club/screens/search_screen.dart/search_screen.dart';
import 'package:flutter/material.dart';
import '../../screens/comments_screen.dart/comments_screen.dart';
import '../../screens/home_screen/home_screen.dart';
import '../../screens/login_screen/login_screen.dart';
import '../../screens/profile_screen/profile_screen.dart';
import '../../screens/register_screen/register_screen.dart';
import '../../screens/root_screen/root_screen.dart';
import '../../screens/splash_screen/splash_screen.dart';

class RoutesHelper {
  static Route? generateRoute(RouteSettings settings) {
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
      case RootScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const RootScreen(),
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
      case ProfileScreen.routeName:
        final profileData = routeArgs as Map;
        return MaterialPageRoute(
          builder: (context) => ProfileScreen(
            isMyProfile: profileData["isMyProfile"],
            userId: profileData["userId"] as String,
          ),
        );
      case SearchScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const SearchScreen(),
        );

      default:
        return null;
    }
  }
}
