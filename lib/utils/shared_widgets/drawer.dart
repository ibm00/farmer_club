import 'package:farmer_club/data/providers/user_data_provider.dart';
import 'package:farmer_club/screens/profile_screen/profile_screen.dart';
import 'package:farmer_club/utils/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/firebase_services/fire_auth.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          children: [
            Consumer(builder: (context, ref, _) {
              return ListTile(
                title: const Text("حسابي", style: kTextStyleReg18),
                leading: const Icon(Icons.person_outline_outlined),
                onTap: () {
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
            Consumer(builder: (context, ref, _) {
              return ListTile(
                title: const Text("تسجيل الخروج", style: kTextStyleReg18),
                leading: const Icon(Icons.logout),
                onTap: () async {
                  ref.read(userDataProvider).postsNum = 0;
                  await FireAuth.signout(context);
                },
              );
            })
          ],
        ),
      ),
    );
  }
}
