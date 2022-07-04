import 'package:farmer_club/data/providers/user_data_provider.dart';
import 'package:farmer_club/screens/profile_screen/profile_screen.dart';
import 'package:farmer_club/screens/search_screen.dart/search_screen.dart';
import 'package:farmer_club/utils/constants/styles.dart';
import 'package:farmer_club/utils/shared_widgets/app_bar_widget.dart';
import 'package:farmer_club/utils/shared_widgets/image_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/firebase_services/fire_auth.dart';
import 'drawer_app_bar.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const DrawerAppBar(),
              const SizedBox(height: 10),
              Consumer(builder: (context, ref, _) {
                return ListTile(
                  title: const Text("حسابي", style: kTextStyleReg18),
                  leading: const Icon(Icons.person_outline_outlined),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed(
                      ProfileScreen.routeName,
                      arguments: {
                        "isMyProfile": true,
                        "userId": ref.watch(userDataProvider).userId,
                      },
                    );
                  },
                );
              }),
              ListTile(
                title: const Text("بحث", style: kTextStyleReg18),
                leading: const Icon(Icons.search),
                onTap: () async {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(SearchScreen.routeName);
                },
              ),
              Consumer(builder: (context, ref, _) {
                return ListTile(
                  title: const Text("تسجيل الخروج", style: kTextStyleReg18),
                  leading: const Icon(Icons.logout),
                  onTap: () async {
                    ref.read(userDataProvider).postsNum = 0;
                    ref.read(userDataProvider).followingsNum = 0;
                    await FireAuth.signout(context);
                  },
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
