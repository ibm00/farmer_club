import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_club/data/providers/user_data_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final intialScreenProvider = FutureProvider<bool>(
  (ref) async {
    await Future.delayed(const Duration(seconds: 3));
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final userDateSnapshot =
          await FirebaseFirestore.instance.doc("users/$userId").get();
      final userData = userDateSnapshot.data();
      if (userData != null) {
        ref.read(userDataProvider).name = userData['name'];
        ref.read(userDataProvider).imageUrl = userData['imageUrl'];
        ref.read(userDataProvider).email = userData['email'];
        ref.read(userDataProvider).userId = userId;
      }

      return true;
    } catch (e) {
      return false;
    }
  },
);
