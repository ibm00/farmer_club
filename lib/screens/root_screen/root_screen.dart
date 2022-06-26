import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../error_screen/error_screen.dart';
import '../home_screen/home_screen.dart';
import '../login_screen/login_screen.dart';
import '../splash_screen/splash_screen.dart';
import 'root_screen_providers.dart';

class RootScreen extends ConsumerWidget {
  static const routeName = "/roote-screen";
  const RootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(intialScreenProvider).when(
          data: (v) => v ? const HomeScreen() : LoginScreen(),
          error: (e, s) => const ErrorScreen(),
          loading: () => SplashScreen(),
        );
  }
}
