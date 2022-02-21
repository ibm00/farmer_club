import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isAuth = StateProvider<bool>((ref) => false);

final intialScreenProvider = FutureProvider<bool>(
  (ref) async {
    await Future.delayed(const Duration(seconds: 3));

    try {
      final userid = FirebaseAuth.instance.currentUser!.uid;
      print(userid);
      return true;
      // ref.read(isAuth.notifier).state == true;
    } catch (e) {
      return false;
      // ref.read(isAuth.notifier).state == false;
    }
  },
);
