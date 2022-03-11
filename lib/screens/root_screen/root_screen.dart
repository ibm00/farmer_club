import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../home_screen/home_screen.dart';
import '../login_screen/login_screen.dart';
import '../splash_screen/splash_screen.dart';
import 'root_screen_providers.dart';

class RooteScreen extends ConsumerWidget {
  static const routeName = "/roote-screen";
  const RooteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final isAuthStatus = ref.watch(isAuth.notifier).state;
    return ref.watch(intialScreenProvider).when(
          data: (v) => v ? const HomeScreen() : LoginScreen(),
          error: (e, s) => SplashScreen(),
          loading: () => SplashScreen(),
        );
  }
}
