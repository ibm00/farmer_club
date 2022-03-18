import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_club/data/models/user_model.dart';

class FireProfile {
  static final firestoreInistance = FirebaseFirestore.instance;

  static Future<UserModel?> getOtherUserData(String userId) async {
    try {
      final userDoc = await firestoreInistance.doc('users/$userId').get();

      if (userDoc.data() != null) return UserModel.fromMap(userDoc.data()!);
      return null;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return null;
    }
  }
}
