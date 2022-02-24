import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final intialScreenProvider = FutureProvider<bool>(
  (ref) async {
    await Future.delayed(const Duration(seconds: 3));
    try {
      FirebaseAuth.instance.currentUser!.uid;
      return true;
    } catch (e) {
      return false;
    }
  },
);
