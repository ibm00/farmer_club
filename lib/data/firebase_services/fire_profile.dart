import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_club/data/models/user_model.dart';

class FireProfile {
  static final firestoreInistance = FirebaseFirestore.instance;

  static Future<UserModel?> getOtherUserData(
    String userId,
    String currentUserId,
  ) async {
    try {
      //fetch current user following list
      final followingSnapshot = await firestoreInistance
          .collection('users/$currentUserId/following')
          .get();
      final currentUserFollwingDocs = followingSnapshot.docs;
      final List<String> currentUserFollowing = [];
      for (var doc in currentUserFollwingDocs) {
        currentUserFollowing.add(doc.id);
      }
      //fetch other user data
      final docRef = firestoreInistance.doc('users/$userId');
      final userDoc = await docRef.get();
      if (userDoc.data() != null) {
        return UserModel.fromMap(userDoc.data()!)
          ..setFollowingState(currentUserFollowing, userId);
      }
      return null;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return null;
    }
  }
}
