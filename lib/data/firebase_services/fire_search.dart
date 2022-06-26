import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_club/data/models/user_model.dart';

class FireSearch {
  static final firestoreInistance = FirebaseFirestore.instance;

  static Future<List<UserModel>?> getAllOtherUsers(String currentUserId) async {
    try {
      //get current user following list
      final currentUserFollwingSnapshot = await firestoreInistance
          .collection(
            "users/$currentUserId/following",
          )
          .get();
      final currentUserFollwingDocs = currentUserFollwingSnapshot.docs;
      final List<String> currentUserFollowing = [];
      for (var doc in currentUserFollwingDocs) {
        currentUserFollowing.add(doc.id);
      }

      //get all users
      final usersCollectionSnapshot =
          await firestoreInistance.collection('users').get();
      final List<UserModel> users = [];
      var usersDocs = usersCollectionSnapshot.docs;

      for (QueryDocumentSnapshot<Map<String, dynamic>> userDoc in usersDocs) {
        final Map<String, dynamic> userMap = userDoc.data()
          ..addAll({"userId": userDoc.id});
        users.add(
          UserModel.fromMap(userMap)..setFollowingState(currentUserFollowing),
        );
      }
      return users;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return null;
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getFollowingUsers(
    String currentUserId,
  ) {
    //get current user following list
    return firestoreInistance
        .collection(
          "users/$currentUserId/following",
        )
        .snapshots();
  }

  static Future<Map?> followPressed({
    required String currentUserId,
    required String otherUserID,
  }) async {
    try {
      //add new following to current user
      final currentUserFollowingCollection = firestoreInistance.collection(
        'users/$currentUserId/following',
      );
      await currentUserFollowingCollection.doc(otherUserID).set(
        {"userId": otherUserID},
      );
      final followingDocs = await currentUserFollowingCollection.get();
      final currentUserFollowingNum = followingDocs.docs.length;
      //update Current user followings num
      final currenUserDocumentRef = currentUserFollowingCollection.parent;
      currenUserDocumentRef!.update({"followingsNum": currentUserFollowingNum});

      //add new follower to other user
      final othertUserFollowersCollection = firestoreInistance.collection(
        'users/$otherUserID/followers',
      );
      await othertUserFollowersCollection.doc(currentUserId).set(
        {"userId": currentUserId},
      );
      final followerDocs = await othertUserFollowersCollection.get();
      final otherUserFollowersNum = followerDocs.docs.length;
      //update other user followers num
      final otherUserDocumentRef = othertUserFollowersCollection.parent;
      otherUserDocumentRef!.update({"followersNum": otherUserFollowersNum});
      return {
        "currentUserFollowingNum": currentUserFollowingNum,
        "otherUserFollowersNum": otherUserFollowersNum
      };
    } catch (e) {
      return null;
    }
  }

  static Future<Map?> unFollowPressed({
    required String currentUserId,
    required String otherUserID,
  }) async {
    try {
      //remove the following from current user
      final currentUserFollowingCollection = firestoreInistance.collection(
        'users/$currentUserId/following',
      );
      await currentUserFollowingCollection.doc(otherUserID).delete();
      final followingDocs = await currentUserFollowingCollection.get();
      final currentUserFollowingNum = followingDocs.docs.length;
      //update Current user followings num
      final currenUserDocumentRef = currentUserFollowingCollection.parent;
      currenUserDocumentRef!.update({"followingsNum": currentUserFollowingNum});

      //delete the follower from other user
      final othertUserFollowersCollection = firestoreInistance.collection(
        'users/$otherUserID/followers',
      );
      await othertUserFollowersCollection.doc(currentUserId).delete();
      final followerDocs = await othertUserFollowersCollection.get();
      final otherUserFollowersNum = followerDocs.docs.length;
      //update other user followers num
      final otherUserDocumentRef = othertUserFollowersCollection.parent;
      otherUserDocumentRef!.update({"followersNum": otherUserFollowersNum});
      return {
        "currentUserFollowingNum": currentUserFollowingNum,
        "otherUserFollowersNum": otherUserFollowersNum
      };
    } catch (e) {
      return null;
    }
  }
}
