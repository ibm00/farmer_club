import 'package:farmer_club/data/firebase_services/fire_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  static const routeName = "/home-screen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          FireAuth.signout(context);
        },
        child: const Center(
          child: Text("Home Screeeen"),
        ),
      ),
    );
  }
}
